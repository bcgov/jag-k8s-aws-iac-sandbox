data "aws_vpc" "tools_vpc" {
  filter {
    name   = "tag:Name"
    values = ["Tools_vpc"]  
  }
}

data "aws_subnet" "app_tools_aza_net" {
  filter {
    name   = "tag:Name"
    values = ["App_Tools_aza_net"]
  }
}

data "aws_subnet" "data_tools_azb_net" {  
  filter {
    name   = "tag:Name"
    values = ["Data_Tools_azb_net"]  
  }
}

data "aws_subnet" "data_tools_aza_net" {  
  filter {
    name   = "tag:Name"
    values = ["Data_Tools_aza_net"]  
  }
}

data "aws_s3_bucket" "sandbox_s3" {
  bucket = "pdems-tf-state"
}

data "aws_security_group" "sandboxdb_group"{
  name = "Data_sg"
}
