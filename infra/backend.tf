terraform {
  backend "s3" {
     bucket = "mybucket880"
     key = "master/.terraform"
     region = "ap-south-1"

}

}
