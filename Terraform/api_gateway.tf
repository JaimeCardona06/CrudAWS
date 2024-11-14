# Crear el HTTP API Gateway
resource "aws_apigatewayv2_api" "API" {
  name          = "api-movies"
  protocol_type = "HTTP"

  cors_configuration {
    allow_origins = ["http://localhost:4200"]
    allow_methods = ["GET", "POST", "PUT", "DELETE", "OPTIONS"]
    allow_headers = ["Content-Type", "Authorization", "X-Amz-Date", "X-Api-Key", "X-Amz-Security-Token"]
  }
}

# Crear las rutas para el recurso "movies"
resource "aws_apigatewayv2_route" "movies_route_post" {
  api_id    = aws_apigatewayv2_api.API.id
  route_key = "POST /movies"
  target    = "integrations/${aws_apigatewayv2_integration.create_movie_integration.id}"
}

resource "aws_apigatewayv2_route" "movies_route_get" {
  api_id    = aws_apigatewayv2_api.API.id
  route_key = "GET /movies"
  target    = "integrations/${aws_apigatewayv2_integration.get_movies_integration.id}"
}

resource "aws_apigatewayv2_route" "movie_by_id_route_get" {
  api_id    = aws_apigatewayv2_api.API.id
  route_key = "GET /movies/{id}"
  target    = "integrations/${aws_apigatewayv2_integration.get_movie_by_id_integration.id}"
}

resource "aws_apigatewayv2_route" "movies_route_put" {
  api_id    = aws_apigatewayv2_api.API.id
  route_key = "PUT /movies/{id}"
  target    = "integrations/${aws_apigatewayv2_integration.update_movie_integration.id}"
}

resource "aws_apigatewayv2_route" "movies_route_delete" {
  api_id    = aws_apigatewayv2_api.API.id
  route_key = "DELETE /movies/{id}"
  target    = "integrations/${aws_apigatewayv2_integration.delete_movie_integration.id}"
}

# Crear las integraciones con Lambda para cada operación
resource "aws_apigatewayv2_integration" "create_movie_integration" {
  api_id           = aws_apigatewayv2_api.API.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.create_movie_lambda.invoke_arn
}

resource "aws_apigatewayv2_integration" "get_movies_integration" {
  api_id           = aws_apigatewayv2_api.API.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.get_movies_lambda.invoke_arn
}

resource "aws_apigatewayv2_integration" "get_movie_by_id_integration" {
  api_id           = aws_apigatewayv2_api.API.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.get_movie_by_id_lambda.invoke_arn
}

resource "aws_apigatewayv2_integration" "update_movie_integration" {
  api_id           = aws_apigatewayv2_api.API.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.update_movie_lambda.invoke_arn
}

resource "aws_apigatewayv2_integration" "delete_movie_integration" {
  api_id           = aws_apigatewayv2_api.API.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.delete_movie_lambda.invoke_arn
}

# Permitir que API Gateway invoque las Lambdas
resource "aws_lambda_permission" "allow_create_movie" {
  statement_id  = "AllowExecutionFromAPIGatewayCreateMovie"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.create_movie_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.AWS_REGION}:${var.AWS_ACCOUNT_ID}:${aws_apigatewayv2_api.API.id}/*/POST/movies"
}

resource "aws_lambda_permission" "allow_get_movies" {
  statement_id  = "AllowExecutionFromAPIGatewayGetMovies"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.get_movies_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.AWS_REGION}:${var.AWS_ACCOUNT_ID}:${aws_apigatewayv2_api.API.id}/*/GET/movies"
}

resource "aws_lambda_permission" "allow_get_movie_by_id" {
  statement_id  = "AllowExecutionFromAPIGatewayGetMovieByID"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.get_movie_by_id_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.AWS_REGION}:${var.AWS_ACCOUNT_ID}:${aws_apigatewayv2_api.API.id}/*/GET/movies/{id}"
}

resource "aws_lambda_permission" "allow_update_movie" {
  statement_id  = "AllowExecutionFromAPIGatewayUpdateMovie"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.update_movie_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.AWS_REGION}:${var.AWS_ACCOUNT_ID}:${aws_apigatewayv2_api.API.id}/*/PUT/movies/{id}"
}

resource "aws_lambda_permission" "allow_delete_movie" {
  statement_id  = "AllowExecutionFromAPIGatewayDeleteMovie"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.delete_movie_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.AWS_REGION}:${var.AWS_ACCOUNT_ID}:${aws_apigatewayv2_api.API.id}/*/DELETE/movies/{id}"
}

# Despliegue de la API
resource "aws_apigatewayv2_stage" "api_stage" {
  api_id      = aws_apigatewayv2_api.API.id
  name        = "prod"
  auto_deploy = true
}

