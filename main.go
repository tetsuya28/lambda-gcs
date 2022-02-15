package main

import (
	"context"
	"log"
	"os"

	"cloud.google.com/go/storage"
	"github.com/aws/aws-lambda-go/lambda"
	"google.golang.org/api/option"
)

func main() {
	lambda.Start(handler)
}

func handler(ctx context.Context) error {
	client, err := storage.NewClient(ctx, option.WithCredentialsJSON([]byte(os.Getenv("GCP_CREDENTIAL"))))
	if err != nil {
		return err
	}

	bucket := client.Bucket(os.Getenv("GCS_BUCKET"))
	attr, err := bucket.Attrs(ctx)
	if err != nil {
		return err
	}

	log.Printf("%+v", attr)

	return nil
}
