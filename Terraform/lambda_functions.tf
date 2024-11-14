# CREATE
resource "aws_lambda_function" "create_movie_lambda" {
  filename      = "${path.module}/funciones_lambda/createMovie.zip"
  function_name = "createMovie"
  role          = aws_iam_role.test_role.arn
  handler       = "createMovie/index.handler"
  runtime       = "nodejs18.x"
}

# GET ALL MOVIES
resource "aws_lambda_function" "get_movies_lambda" {
  filename      = "${path.module}/funciones_lambda/getMovies.zip"
  function_name = "getAllMovies"
  role          = aws_iam_role.test_role.arn
  handler       = "getMovies/index.handler"
  runtime       = "nodejs18.x"
}

# GET MOVIE BY ID
resource "aws_lambda_function" "get_movie_by_id_lambda" {
  filename      = "${path.module}/funciones_lambda/getMoviesById.zip"
  function_name = "getOneMovie"
  role          = aws_iam_role.test_role.arn
  handler       = "getMoviesById/index.handler"
  runtime       = "nodejs18.x"
}

# DELETE MOVIE
resource "aws_lambda_function" "delete_movie_lambda" {
  filename      = "${path.module}/funciones_lambda/deleteMovie.zip"
  function_name = "deleteMovie"
  role          = aws_iam_role.test_role.arn
  handler       = "deleteMovie/index.handler"
  runtime       = "nodejs18.x"
}

# UPDATE MOVIE
resource "aws_lambda_function" "update_movie_lambda" {
  filename      = "${path.module}/funciones_lambda/updateMovie.zip"
  function_name = "updateMovie"
  role          = aws_iam_role.test_role.arn
  handler       = "updateMovie/index.handler"
  runtime       = "nodejs18.x"
}

# SUBIR PELICULAS
resource "aws_lambda_function" "subir_peliculas_lambda" {
  filename      = "${path.module}/funciones_lambda/subir_peliculas.zip"
  function_name = "subir_peliculas"
  role          = aws_iam_role.test_role.arn
  handler       = "subir_peliculas.lambda_handler"
  runtime       = "python3.8"
}


