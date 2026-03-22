package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"strings"
)

// colInfo はカラム名と回答の対応を定義する
// invert=true: a=0(A選択) → col=true、a=1(B選択) → col=false
// invert=false: a=0(A選択) → col=false、a=1(B選択) → col=true
type colInfo struct {
	col    string
	invert bool
}

// colMap は質問番号とDBカラムの対応表（単一の正規化された定義）
var colMap = map[int]colInfo{
	1:  {"is_retro", true},
	2:  {"is_party", true},
	3:  {"is_action", true},
	4:  {"is_long_play", true},
	5:  {"is_hard", true},
	6:  {"is_strategic", true},
	7:  {"is_story_driven", true},
	8:  {"is_educational", true},
	9:  {"is_sports", true},
	10: {"is_collectible", true},
}

// NextQResponse は /api/next-question のレスポンス型
type NextQResponse struct {
	Done      bool      `json:"done"`
	Question  *Question `json:"question,omitempty"`
	Remaining int       `json:"remaining,omitempty"`
	Games     []Game    `json:"games,omitempty"`
	Total     int       `json:"total,omitempty"`
}

// buildWhere は回答済みの質問からWHERE句と引数スライスを生成する
func buildWhere(body map[string]int) (string, []any, map[string]bool) {
	var parts []string
	var args []any
	answered := map[string]bool{}

	for qNum, ci := range colMap {
		key := fmt.Sprintf("a%d", qNum)
		val, ok := body[key]
		if !ok {
			continue
		}
		want := val == 1
		if ci.invert {
			want = !want
		}
		parts = append(parts, ci.col+"=?")
		args = append(args, want)
		answered[ci.col] = true
	}

	where := ""
	if len(parts) > 0 {
		where = " WHERE " + strings.Join(parts, " AND ")
	}
	return where, args, answered
}

// nextQuestionHandler は決定木アルゴリズムで次の質問または結果を返す
func nextQuestionHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
		return
	}

	var body map[string]int
	if err := json.NewDecoder(r.Body).Decode(&body); err != nil {
		http.Error(w, "Bad request", http.StatusBadRequest)
		return
	}

	where, args, answered := buildWhere(body)

	// 現在の残りゲーム数を取得
	var remaining int
	if err := db.QueryRow("SELECT COUNT(*) FROM games"+where, args...).Scan(&remaining); err != nil {
		log.Println("COUNT error:", err)
		http.Error(w, "error", http.StatusInternalServerError)
		return
	}

	// 終了条件: 1件以下 または 全10問回答済み
	if remaining <= 1 || len(answered) >= 10 {
		sendGames(w, where, args, remaining)
		return
	}

	// 最初の2問は固定順 (Q1→Q2)
	fixedOrder := []int{1, 2}
	if len(answered) < 2 {
		for _, qNum := range fixedOrder {
			if answered[colMap[qNum].col] {
				continue
			}
			var nextQ *Question
			for i := range questions {
				if questions[i].Number == qNum {
					q := questions[i]
					nextQ = &q
					break
				}
			}
			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(NextQResponse{
				Done:      false,
				Question:  nextQ,
				Remaining: remaining,
			})
			return
		}
	}

	// 3問目以降: 最もバランスよく分割できるカラムを探す
	bestQNum := -1
	bestBalance := -1

	for qNum, ci := range colMap {
		if answered[ci.col] {
			continue
		}

		// このカラムが true のゲーム数を取得
		extArgs := append(args[:len(args):len(args)], true)
		extWhere := where
		if extWhere == "" {
			extWhere = " WHERE " + ci.col + "=?"
		} else {
			extWhere += " AND " + ci.col + "=?"
		}

		var trueCount int
		if err := db.QueryRow("SELECT COUNT(*) FROM games"+extWhere, extArgs...).Scan(&trueCount); err != nil {
			continue
		}
		falseCount := remaining - trueCount

		// スコア = min(trueCount, falseCount): 高いほど均等な分割
		balance := trueCount
		if falseCount < balance {
			balance = falseCount
		}

		if balance > 0 && balance > bestBalance {
			bestBalance = balance
			bestQNum = qNum
		}
	}

	// 有効な分割が見つからなければ結果を返す
	if bestQNum == -1 {
		sendGames(w, where, args, remaining)
		return
	}

	// 対応する質問オブジェクトを探す
	var nextQ *Question
	for i := range questions {
		if questions[i].Number == bestQNum {
			q := questions[i]
			nextQ = &q
			break
		}
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(NextQResponse{
		Done:      false,
		Question:  nextQ,
		Remaining: remaining,
	})
}

// sendGames はゲーム一覧を含む終了レスポンスを書き込む
func sendGames(w http.ResponseWriter, where string, args []any, total int) {
	rows, err := db.Query("SELECT id, title, COALESCE(official_url, '') FROM games"+where+" LIMIT 1", args...)
	if err != nil {
		log.Println("DB error:", err)
		http.Error(w, "error", http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	var games []Game
	for rows.Next() {
		var g Game
		if err := rows.Scan(&g.ID, &g.Title, &g.OfficialURL); err != nil {
			log.Println("Scan error:", err)
			continue
		}
		games = append(games, g)
	}
	if games == nil {
		games = []Game{}
	}

	for i, g := range games {
		sRows, err := db.Query("SELECT similar_title, COALESCE(official_url, '') FROM game_similarities WHERE game_id = ?", g.ID)
		if err != nil {
			log.Println("similar_title query error:", err)
			continue
		}
		for sRows.Next() {
			var item SimilarItem
			if err := sRows.Scan(&item.Title, &item.OfficialURL); err == nil {
				games[i].SimilarItems = append(games[i].SimilarItems, item)
			}
		}
		sRows.Close()
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(NextQResponse{
		Done:  true,
		Games: games,
		Total: total,
	})
}

