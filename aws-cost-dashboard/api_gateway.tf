# Create API Gateway REST API
resource "aws_api_gateway_rest_api" "cost_api" {
  name        = "CostDataAPI"
  description = "API to fetch AWS cost data"
}

# Create API Resource
resource "aws_api_gateway_resource" "cost_resource" {
  rest_api_id = aws_api_gateway_rest_api.cost_api.id
  parent_id   = aws_api_gateway_rest_api.cost_api.root_resource_id
  path_part   = "cost"
}

# Create API Method (GET request)
resource "aws_api_gateway_method" "cost_method" {
  rest_api_id   = aws_api_gateway_rest_api.cost_api.id
  resource_id   = aws_api_gateway_resource.cost_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

# Connect API Gateway to Lambda
resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id = aws_api_gateway_rest_api.cost_api.id
  resource_id = aws_api_gateway_resource.cost_resource.id
  http_method = aws_api_gateway_method.cost_method.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.cost_lambda.invoke_arn
}

# Create API Gateway Deployment
resource "aws_api_gateway_deployment" "cost_deployment" {
  depends_on  = [aws_api_gateway_integration.lambda_integration]
  rest_api_id = aws_api_gateway_rest_api.cost_api.id
}

# Create API Gateway Stage for 'prod'
resource "aws_api_gateway_stage" "prod_stage" {
  stage_name   = "prod"
  rest_api_id  = aws_api_gateway_rest_api.cost_api.id
  deployment_id = aws_api_gateway_deployment.cost_deployment.id
}

# Give API Gateway permission to invoke Lambda
resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.cost_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.cost_api.execution_arn}/*/*"
}
