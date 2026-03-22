package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
)

type SimilarItem struct {
	Title       string `json:"title"`
	OfficialURL string `json:"official_url,omitempty"`
}

type Game struct {
	ID           int           `json:"id"`
	Title        string        `json:"title"`
	OfficialURL  string        `json:"official_url,omitempty"`
	SimilarItems []SimilarItem `json:"similar_items,omitempty"`
}

type ResultResponse struct {
	Games []Game `json:"games"`
	Total int    `json:"total"`
}

// countHandler は回答済みの質問だけを条件にして件数を返す（デバッグ用）
func countHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
		return
	}
	var body map[string]int
	if err := json.NewDecoder(r.Body).Decode(&body); err != nil {
		http.Error(w, "Bad request", http.StatusBadRequest)
		return
	}

	where, args, _ := buildWhere(body) // decision_tree.go で定義

	var count int
	if err := db.QueryRow("SELECT COUNT(*) FROM games"+where, args...).Scan(&count); err != nil {
		log.Println("COUNT エラー:", err)
		http.Error(w, "error", http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(map[string]int{"count": count})
}

func questionsHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(questions)
}

// resultHandler は二分木探索のフォールバック（全8問をAND条件で検索）
// 決定木では /api/next-question を使うこと
func resultHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
		return
	}

	var body map[string]int
	if err := json.NewDecoder(r.Body).Decode(&body); err != nil {
		http.Error(w, "Bad request", http.StatusBadRequest)
		return
	}

	ans := make(map[int]bool)
	for _, q := range questions {
		ans[q.Number] = body[fmt.Sprintf("a%d", q.Number)] == 1
	}

	// Q1:  A=レトロ(true)       / B=モダン(false)
	// Q2:  A=パーティ(true)    / B=ひとり(false)
	// Q3:  A=アクション(true)  / B=ほのぼの(false)
	// Q4:  A=どっぷり(true)    / B=サクッと(false)
	// Q5:  A=歯ごたえ(true)   / B=気軽(false)
	// Q6:  A=爽快感(false)     / B=戦略(true)
	// Q7:  A=物語(true)        / B=動き(false)
	// Q8:  A=勉強(true)        / B=非日常(false)
	// Q9:  A=スポーツ(true)    / B=別の遊び(false)
	// Q10: A=コレクション(true)/ B=冒険(false)
	wantRetro        := !ans[1]
	wantParty        := !ans[2]
	wantAction       := !ans[3]
	wantLong         := !ans[4]
	wantHard         := !ans[5]
	wantStrategic    := ans[6]
	wantStory        := !ans[7]
	wantEducational  := !ans[8]
	wantSports       := !ans[9]
	wantCollectible  := !ans[10]

	args := []any{wantRetro, wantParty, wantAction, wantLong, wantHard, wantStrategic, wantStory, wantEducational, wantSports, wantCollectible}
	where := `WHERE is_retro=? AND is_party=? AND is_action=? AND is_long_play=?
		  AND is_hard=? AND is_strategic=? AND is_story_driven=? AND is_educational=?
		  AND is_sports=? AND is_collectible=?`

	var total int
	if err := db.QueryRow("SELECT COUNT(*) FROM games "+where, args...).Scan(&total); err != nil {
		log.Println("COUNT エラー:", err)
		http.Error(w, "データ取得に失敗しました", http.StatusInternalServerError)
		return
	}

	rows, err := db.Query("SELECT id, title, COALESCE(official_url, '') FROM games "+where+" LIMIT 1", args...)
	if err != nil {
		log.Println("DB エラー:", err)
		http.Error(w, "データ取得に失敗しました", http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	var games []Game
	for rows.Next() {
		var g Game
		if err := rows.Scan(&g.ID, &g.Title, &g.OfficialURL); err != nil {
			log.Println("Scan エラー:", err)
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
			log.Println("similar_title query エラー:", err)
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
	json.NewEncoder(w).Encode(ResultResponse{Games: games, Total: total})
}
