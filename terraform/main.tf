terraform {
    backend "s3" {
      bucket = "terraformutopiosm2i"
      key = "devsecops/terraform.state"
      region = "us-east-2"
    }
}
provider "aws" {
    region= var.AWS_REGION
    access_key = var.AWS_ACCESS_KEY
    secret_key = var.AWS_SECRET_KEY
}

resource "aws_security_group" "instance_group" {
    name = "test-group-terraform-${terraform.workspace}"
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
data "aws_ami" "get_ubuntu_ami" {
    most_recent = true
    owners = [100000]
    filter {
        name = "name"
        values = ["ubuntu"]
    }
}
resource "aws_key_pair" "key_ssh" {
    key_name = "test-terraform-${terraform.workspace}"
    public_key = file("./ter.pub")
}
resource "aws_instance" "first_instance_3" {
    instance_type = "t2.micro"
    ami = data.aws_ami.get_ubuntu_ami.id
    tags = {
        Name = "instance-${terraform.workspace}"
    }
    key_name = aws_key_pair.key_ssh.key_name
    vpc_security_group_ids=[aws_security_group.instance_group.id]
    connection {
        type = "ssh"
        user = "ubuntu"
        private_key = file("./ter")
        host = self.public_ip
    }
    
    provisioner "remote-exec" {
        inline = [
            "sudo apt-get update"
        ]
    }
    
    provisioner "local-exec" {
        command = "echo ${aws_instance.first_instance_3.public_ip} >> adresses-ip.txt"
    }

    # provisioner "file" {
    #     source = "./toCopy"
    #     destination = "/var/www/html"
    # }
}

module "test_module" {
    source = "./module-terraform"
    test_variable = "valeur de la variable"
}
# resource "aws_iam_user" "new_user" {
#     count = length(var.AWS_USERS)
#     name = var.AWS_USERS[count.index]
# }

output aws_ip_instance {
  value       = aws_instance.first_instance_3.public_ip
  
}
output get_result_test_module {
  value       = test_module.result_module
  sensitive   = true
  description = "description"
  depends_on  = []
}
