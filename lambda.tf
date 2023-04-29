
resource "aws_lambda_function" "cognito_verification_email" {
  filename         = "cognito_verification_email.zip"
  function_name    = "cognito_verification_email"
  role             = aws_iam_role.lambda.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.7"
  timeout          = 60
  memory_size      = 128

  environment {
    variables = {
      VERIFICATION_URL = "https://example.com/verify?token={erdf}"
    }
  }
}

resource "aws_lambda_permission" "cognito_verification_email_invoke_permission" {
  statement_id  = "AllowExecutionFromCognito"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.cognito_verification_email.function_name
  principal     = "cognito-idp.amazonaws.com"
}