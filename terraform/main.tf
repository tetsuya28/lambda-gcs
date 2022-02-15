locals {
  function_name = "gcs_sample"
  output_path   = "../bin/main.zip"
}

data "aws_caller_identity" "current" {}
