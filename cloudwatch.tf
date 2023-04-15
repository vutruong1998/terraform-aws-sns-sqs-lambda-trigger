resource "aws_cloudwatch_log_group" "terraform_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.terraform_lambda.function_name}"
  retention_in_days = 7
}

