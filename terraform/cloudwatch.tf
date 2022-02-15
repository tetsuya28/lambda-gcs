resource "aws_cloudwatch_log_group" "default" {
  name              = "/aws/lambda/${local.function_name}"
  retention_in_days = 1
}

resource "aws_iam_policy" "default" {
  name        = "${local.function_name}-lambda_logging"
  path        = "/"
  description = "IAM policy for logging from ${local.function_name}"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:${data.aws_caller_identity.current.account_id}:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.default.name
  policy_arn = aws_iam_policy.default.arn
}
