terraform {
  backend "s3" {
    bucket = "shafeeque-tfstate-bucket"
    key    = "lab/eks/terraform.tfstate"
    region = "ap-south-1"
  }
}


