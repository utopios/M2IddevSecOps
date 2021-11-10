provider "aws" {
    region= var.AWS_REGION
    access_key = var.AWS_ACCESS_KEY
    secret_key = var.AWS_SECRET_KEY
}

resource "aws_security_group" "instance_group" {
    name = "test-group-terraform"
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
resource "aws_key_pair" "key_ssh" {
    key_name = "test-terraform"
    public_key = file("./ter.pub")
}
resource "aws_instance" "first_instance_3" {
    instance_type = "t2.micro"
    ami = "ami-0629230e074c580f2"
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

    provisioner "file" {
        source = "./toCopy"
        destination = "/var/www/html"
    }
}


# resource "aws_iam_user" "new_user" {
#     count = length(var.AWS_USERS)
#     name = var.AWS_USERS[count.index]
# }

output aws_ip_instance {
  value       = aws_instance.first_instance_3.public_ip
  
}
