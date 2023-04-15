resource "aws_sns_topic" "terraform_sns_topic" {
  name                        = var.sns["name"]
  display_name                = var.sns["display_name"]
  fifo_topic                  = true
  content_based_deduplication = true
  policy                      = <<POLICY
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws:sns:${var.sns["region"]}:${var.sns["account_id"]}:${var.sns["name"]}",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "${var.sns["account_id"]}"
        }
      }
    }
  ]
}
  POLICY
}

resource "aws_sns_topic_subscription" "terraform_sns_topic" {
  topic_arn = aws_sns_topic.terraform_sns_topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.terraform_sqs.arn
}