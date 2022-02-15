## lambda-gcs sample
To access GCS from AWS Lambda using GCP credential json.

## Setup
1. Build go
	```
	$ make build
	```

1. Set GCP credential json in `./terraform/serviceAccountCreds.json`
	```
	$ cat terraform/serviceAccountCreds.json
	{
	  "type": "",
	  ...
	}
	```

1. Terraform apply
	```
	$ cd terraform
	$ terraform apply
	```
