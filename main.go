package main

import (
	"database/sql"
	"fmt"
	"net/http"
	"os"
	"os/exec"

	_ "github.com/lib/pq"
)

// ⚠️ Security Hotspot: Hardcoded credentials
const dbUser = "admin"
const dbPassword = "password123"

func main() {
	http.HandleFunc("/user", getUser)
	http.HandleFunc("/exec", runCommand)

	fmt.Println("Server running on port 8080")
	http.ListenAndServe(":8080", nil) // 🐞 Bug: error ignored
}

// 🚨 Vulnerability: SQL Injection
func getUser(w http.ResponseWriter, r *http.Request) {
	user := r.URL.Query().Get("id")

	connStr := fmt.Sprintf("user=%s password=%s dbname=test sslmode=disable", dbUser, dbPassword)
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		fmt.Fprintf(w, "DB error")
		return
	}
	defer db.Close()

	// ❌ Unsafe query (SQL Injection)
	query := "SELECT name FROM users WHERE id = " + user

	rows, err := db.Query(query)
	if err != nil {
		fmt.Fprintf(w, "Query error")
		return
	}
	defer rows.Close()

	for rows.Next() {
		var name string
		rows.Scan(&name) // 🐞 Bug: error ignored
		fmt.Fprintf(w, "User: %s\n", name)
	}
}

// 🚨 Vulnerability: Command Injection
func runCommand(w http.ResponseWriter, r *http.Request) {
	cmdParam := r.URL.Query().Get("cmd")

	// ❌ Unsafe execution
	cmd := exec.Command("sh", "-c", cmdParam)
	output, err := cmd.Output()
	if err != nil {
		fmt.Fprintf(w, "Command error")
		return
	}

	fmt.Fprintf(w, string(output))
}

// 🐞 Bug: Nil pointer dereference possibility
func riskyFunction() {
	var ptr *int
	fmt.Println(*ptr) // panic at runtime
}

// ⚠️ Security Hotspot: Environment variable misuse
func insecureEnvUsage() {
	apiKey := os.Getenv("API_KEY") // might be empty or insecure
	fmt.Println("API Key:", apiKey)
}