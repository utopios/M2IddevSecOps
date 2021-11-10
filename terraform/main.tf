provider "aws" {
    region= var.AWS_REGION
    access_key = var.AWS_ACCESS_KEY
    secret_key = var.AWS_SECRET_KEY
}

resource "aws_instance" "first_instance" {
    instance_type = "t2.micro"
    ami = "ami-0629230e074c580f2"
}