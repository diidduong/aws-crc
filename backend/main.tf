terraform {
  cloud {
    organization = "Banavocado"
    workspaces {
      name = "aws-crc"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.38.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "archive_file" "zip_visitor_counter" {
  type        = "zip"
  source_dir  = "${path.module}/visitor_counter/"
  output_path = "${path.module}/visitor_counter.zip"
}

resource "aws_lambda_function" "visitor_counter" {
  filename      = "${path.module}/visitor_counter.zip"
  function_name = "visitor_counter"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "app.lambda_handler"
  runtime       = "python3.9"
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  description        = "IAM Policy for backend Cloud Resume Challenge"
  assume_role_policy = data.aws_iam_policy_document.assume_role_for_lambda.json
}

data "aws_iam_policy_document" "assume_role_for_lambda" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com",
      ]
    }
  }
}

resource "aws_iam_policy" "iam_policy_for_lambda" {
  name        = "aws_iam_policy_for_terraform_aws_lambda_role"
  path        = "/"
  description = "AWS IAM Policy for managing aws lambda role"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
          ],
          "Resource" : "arn:aws:logs:*:*:*",
          "Effect" : "Allow"
        },
        {
          "Action" : [
            "dynamodb:GetItem",
            "dynamodb:UpdateItem"
          ],
          "Resource" : "arn:aws:dynamodb:*:*:table/aws-crc",
          "Effect" : "Allow"
        }
      ]
  })
}
resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.iam_policy_for_lambda.arn
}

resource "aws_lambda_function_url" "visitor_counter_url" {
  function_name      = aws_lambda_function.visitor_counter.function_name
  authorization_type = "NONE"

  cors {
    allow_credentials = false
    allow_origins     = ["https://www.haerowin.com"]
    allow_methods     = ["*"]
    allow_headers     = ["date", "keep-alive"]
    expose_headers    = ["keep-alive", "date"]
    max_age           = 86400
  }
}
