# Configurar el proveedor
provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAWF7KFT75Y5TQ7CU6"
  secret_key = "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"
}

#Datos del AMI
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

#Creación del recurso
resource "aws_instance" "web" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  key_name = "Terraform-USAC-V2"//You have to change here with your key name
  vpc_security_group_ids = [ "sg-0c79f2e1d160c8c2f" ]//You have to change here with the id of your security group
  subnet_id = "subnet-0faaeabc37d094caa"//You have to replace here with your public subnet
  associate_public_ip_address = true

  tags = {
    Name = "web-server-tf-usac"
  }
}

output "public_ip" {
  value       = aws_instance.web.public_ip
}
