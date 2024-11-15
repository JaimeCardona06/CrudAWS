resource "aws_dynamodb_table" "csv_table" {
  name         = "movies"
  hash_key     = "id"
  read_capacity  = 5
  write_capacity = 5

  attribute {
    name = "id"
    type = "S"
  }
}
