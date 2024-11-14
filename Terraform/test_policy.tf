resource "aws_iam_role_policy" "rol_policy" {
  name   = "cloudwatch-policy"
  role   = aws_iam_role.test_role.id
  policy = file("${path.module}/test_role.json")
}

resource "aws_iam_role_policy" "s3_access_policy" {
  name   = "lambda-s3-access"
  role   = aws_iam_role.test_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "s3:GetObject"
        Resource = "arn:aws:s3:::subir-archivos-peliculas/*"
      }
    ]
  })
}

resource "aws_iam_role_policy" "dynamodb_access_policy" {
  name   = "lambda-dynamodb-access"
  role   = aws_iam_role.test_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "dynamodb:PutItem",
          "dynamodb:Scan",   
          "dynamodb:GetItem",  
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem"
        ]
        Resource = "arn:aws:dynamodb:us-east-1:703671900631:table/movies"
      }
    ]
  })
}

