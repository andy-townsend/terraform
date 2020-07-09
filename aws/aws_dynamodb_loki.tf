# Create a dynamodb table for Loki index
# Notes on requirements from - https://github.com/grafana/loki/blob/d33722dc71559a1cfd150eb4926b073537ce4c5c/docs/operations.md#dynamodb

resource "aws_dynamodb_table" "ddb-table-loki-index" {
  name           = "prd-loki-index"
  billing_mode   = "PROVISIONED"
  read_capacity  = 10
  write_capacity = 10
  hash_key       = "h"
  range_key      = "r"

  attribute {
    name = "h"
    type = "S"
  }

  attribute {
    name = "r"
    type = "B"
  }
  
  point_in_time_recovery {
    enabled = true
  }
}