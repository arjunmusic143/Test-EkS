resource "aws_db_instance" "rdsint" {
  identifier             = var.identifier
  allocated_storage    = var.storage
  engine                = var.engine
  engine_version        = var.engine_version
  instance_class        = var.instance_class
  db_name              = var.db_name
  username               = var.username
  password            = var.password
  db_subnet_group_name = aws_db_subnet_group.dbgroup[0].id 
  vpc_security_group_ids = [aws_security_group.sg-all.id]
}
