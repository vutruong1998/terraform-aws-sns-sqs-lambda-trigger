variable "sns" {
  default = {
    account_id   = "AWS_ACCOUNT_ID"
    role-name    = "service/service-hashicorp-terraform"
    name         = "terraform-sns-topic.fifo"
    display_name = "Terraform SNS Topic"
    region       = "ap-northeast-2"
  }
}

variable "sqs" {
  default = {
    account_id = "AWS_ACCOUNT_ID"
    role-name  = "service/service-hashicorp-terraform"
    name       = "terraform-sqs.fifo"
    region     = "ap-northeast-2"
  }
}
