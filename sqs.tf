resource "aws_sqs_queue" "terraform_sqs" {
  name                      = var.sqs["name"]
  delay_seconds             = 0
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  #   redrive_policy = jsonencode({
  #     deadLetterTargetArn = aws_sqs_queue.terraform_queue_deadletter.arn
  #     maxReceiveCount     = 4
  #   })

  fifo_queue                  = true
  content_based_deduplication = true
}

resource "aws_sqs_queue_policy" "terraform_sqs_policy" {
  queue_url = aws_sqs_queue.terraform_sqs.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "__owner_statement",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${var.sqs["account_id"]}:root"
      },
      "Action": "SQS:*",
      "Resource": "${aws_sqs_queue.terraform_sqs.arn}"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "sns.amazonaws.com"
      },
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.terraform_sqs.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_sns_topic.terraform_sns_topic.arn}"
        }
      }
    }
  ]
}
POLICY
}