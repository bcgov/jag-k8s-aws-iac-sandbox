terraform {
  backend "s3" {
    bucket =  "pdems-tf-state" 
    key    = "terraform.tfstate"                   
    region = "ca-central-1"                         
  }
}