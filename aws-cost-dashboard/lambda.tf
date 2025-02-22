resource "aws_lambda_function" "cost_lambda" {
  function_name    = "aws-cost-fetcher"
  role            = aws_iam_role.lambda_role.arn
  handler         = "lambda_function.lambda_handler"
  runtime         = "python3.9"
  timeout         = 30

  filename         = "lambda.zip"
  source_code_hash = filebase64sha256("lambda.zip")

  environment {
    variables = {
      MY_AWS_REGION = var.aws_region  # Renamed to avoid using a reserved key
    }
  }
}
