resource "aws_dynamodb_table" "csv_table" {
  name         = "movies"
  hash_key     = "id"  # Asegúrate de usar un campo único para el hash_key
  read_capacity  = 5
  write_capacity = 5

  attribute {
    name = "id"
    type = "S"
  }
}
