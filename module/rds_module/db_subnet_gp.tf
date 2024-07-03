resource "aws_db_subnet_group" "dbgroup" {
  count = 2
  subnet_ids  = var.subnet_ids
}