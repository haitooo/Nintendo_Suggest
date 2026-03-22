package main

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"
	"os"
	"time"

	_ "github.com/go-sql-driver/mysql"
)

var db *sql.DB

func main() {
	var err error

	dsn := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?parseTime=true&charset=utf8mb4",
		getEnv("DB_USER", "user"),
		getEnv("DB_PASSWORD", "password"),
		getEnv("DB_HOST", "localhost"),
		getEnv("DB_PORT", "3306"),
		getEnv("DB_NAME", "nintendo_suggest"),
	)

	for i := 0; i < 30; i++ {
		db, err = sql.Open("mysql", dsn)
		if err == nil {
			err = db.Ping()
		}
		if err == nil {
			log.Println("データベース接続成功")
			break
		}
		log.Printf("データベース待機中... (%d/30)\n", i+1)
		time.Sleep(2 * time.Second)
	}
	if err != nil {
		log.Fatal("データベース接続失敗:", err)
	}
	defer db.Close()

	http.HandleFunc("/api/questions", questionsHandler)
	http.HandleFunc("/api/count", countHandler)
	http.HandleFunc("/api/next-question", nextQuestionHandler) // 決定木
	http.HandleFunc("/api/result", resultHandler)              // 二分木フォールバック

	log.Println("APIサーバー起動: http://localhost:8080")
	log.Fatal(http.ListenAndServe(":8080", nil))
}

func getEnv(key, fallback string) string {
	if v := os.Getenv(key); v != "" {
		return v
	}
	return fallback
}
