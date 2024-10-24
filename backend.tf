terraform {
  backend "s3" {
    bucket = "terraform"  
    key    = "terraform.tfstate"                   
    region = "ca-central-1"                          
  }
}