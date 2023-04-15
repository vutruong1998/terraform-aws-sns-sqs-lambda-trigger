data "archive_file" "terraform_lambda" {
  type        = "zip"
  source_file = "${path.module}/terraform_lambda.js"
  output_path = "${path.module}/terraform_lambda.js.zip"
}

resource "aws_lambda_function" "terraform_lambda" {
  function_name = "terraform_lambda"
  handler       = "terraform_lambda.handler"
  role          = aws_iam_role.terraform_iam_for_lambda.arn
  runtime       = "nodejs16.x"

  filename         = data.archive_file.terraform_lambda.output_path
  source_code_hash = data.archive_file.terraform_lambda.output_base64sha256

  timeout     = 30
  memory_size = 128
}