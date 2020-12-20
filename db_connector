package main

import (
	"fmt"

	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/postgres"
)

func add(x, y int) int {
	return x + y
}

func main() {
	db, err := gorm.Open("postgres", "user=postgres password=root dbname=World sslmode=disable")

	if err != nil {
		panic(err.Error())
	}
	defer db.Close()

	database := db.DB()

	err = database.Ping()

	if err != nil {
		panic(err.Error())
	}

	fmt.Println("Connection to PostgreSQL was successful!")
}
