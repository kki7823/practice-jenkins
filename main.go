package main

import (
	"context"

	"github.com/gin-gonic/gin"
)

func main() {
	ctx := context.Background()
	if err := runServer(ctx); err != nil {
		panic(err)
	}
}

func runServer(ctx context.Context) error {
	router := gin.Default()
	router.GET("/sample", sampleHandler())

	return router.Run(":8080")
}

func sampleHandler() gin.HandlerFunc {
	return func(ctx *gin.Context) {
		ctx.JSON(200, "Hello World")
	}
}
