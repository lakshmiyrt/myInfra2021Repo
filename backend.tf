terraform {
  backend "s3" {
    bucket = "mys3bucket1984"
    key = "main"
    region = "us-east-1"
    dynamodb_table = "my-dynamodb-table"
  }
}
