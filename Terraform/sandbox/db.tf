resource "aws_db_subnet_group" "sandbox_subnets" {
  name       = "sandbox-subnet-group"
  subnet_ids = [
    data.aws_subnet.data_tools_aza_net.id,
    data.aws_subnet.data_tools_azb_net.id,
  ]

  tags = {
    Name = "sandbox_db_subnet_group"
  }
}

resource "aws_db_instance" "sandbox_db_instance" {
  identifier              = "sandbox-airbyte-db"
  engine                  = "postgres"
  engine_version          = "15.5"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  storage_type            = "gp2"

  db_name                 = "airbyte"
  username                = "airbyte_user"
  password                = "airbyteuserpdems"
  db_subnet_group_name    = aws_db_subnet_group.sandbox_subnets.name
  vpc_security_group_ids  = [data.aws_security_group.sandboxdb_group.id]
  multi_az                = false
  publicly_accessible     = false
  skip_final_snapshot     = true

  tags = {
    Name = "AirbyteManagedPostgres"
  }
}

# Output credentials and address for Kubernetes Secret creation
output "db_address" {
  value = aws_db_instance.sandbox_db_instance.address
}
