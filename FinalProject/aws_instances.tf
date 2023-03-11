provider "aws" {
  access_key = "paste"
  secret_key = "paste"
  region = "eu-central-1"
}

resource "aws_instance" "ansible" {
  ami = "ami-06616b7884ac98cdd"
  instance_type = "t2.micro"
  key_name = "general"
  associate_public_ip_address = true
  tags = {
    Name = "ansible"
  }
}

resource "aws_instance" "jenkins" {
  ami = "ami-06616b7884ac98cdd"
  instance_type = "t2.micro"
  key_name = "general"
  associate_public_ip_address = true
  tags = {
    Name = "jenkins"
  }
}

resource "aws_instance" "webserver" {
  ami = "ami-06616b7884ac98cdd"
  instance_type = "t2.micro"
  key_name = "general"
  associate_public_ip_address = true
  tags = {
    Name = "webserver"
  }
}
