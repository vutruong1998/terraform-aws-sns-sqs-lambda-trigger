resource "aws_lambda_event_source_mapping" "terraform_lambda_event" {
  event_source_arn = aws_sqs_queue.terraform_sqs.arn
  function_name    = aws_lambda_function.terraform_lambda.arn
}