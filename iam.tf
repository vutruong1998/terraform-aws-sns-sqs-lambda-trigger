resource "aws_iam_role" "terraform_iam_for_lambda" {
  name = "terrform_iam_for_lambda"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        Effect : "Allow",
        Action : "sts:AssumeRole",
        Principal : {
          Service : "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "terraform_sqs_and_func_log_policy" {
  name = "terraform_sqs_and_func_log_policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        Effect : "Allow",
        Action : [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource : "arn:aws:logs:*:*:*"
      },
      {
        Effect : "Allow",
        Action : "sqs:*",
        Resource : "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "terraform_sqs_func_log_policy_attachment" {
  role       = aws_iam_role.terraform_iam_for_lambda.id
  policy_arn = aws_iam_policy.terraform_sqs_and_func_log_policy.arn
}