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

# resource "aws_db_instance" "sandbox_db_instance" {
#   identifier              = "sandbox-db"
#   engine                 = "Sandbox_sql_server"
#   engine_version         = "8.0.39"  
#   instance_class         = "db.t3.micro"  
#   allocated_storage       = 20  
#   storage_type           = "gp2"  
#   username               = jsondecode(aws_secretsmanager_secret_version.pdems_secret_version.secret_string)["username"]
#   password               = jsondecode(aws_secretsmanager_secret_version.pdems_secret_version.secret_string)["password"]
#   db_subnet_group_name   = aws_db_subnet_group.sandbox_subnets.name
#   vpc_security_group_ids = [data.aws_security_group.sandboxdb_group.id]
#   multi_az               = false
#   skip_final_snapshot    = true  

#   tags = {
#     Name = "AirbyteManaged DB"
#   }
# }