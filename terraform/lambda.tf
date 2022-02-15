data "archive_file" "default" {
  type        = "zip"
  source_file = "../bin/main"
  output_path = local.output_path
}

resource "aws_lambda_function" "default" {
  filename         = local.output_path
  function_name    = local.function_name
  source_code_hash = data.archive_file.default.output_base64sha256
  runtime          = "go1.x"
  handler          = "main"
  role             = aws_iam_role.default.arn
  environment {
    variables = {
      GCS_BUCKET     = var.gcs_bucket
      GCP_CREDENTIAL = file("serviceAccountCreds.json")
    }
  }
}

resource "aws_iam_role" "default" {
  name               = local.function_name
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
