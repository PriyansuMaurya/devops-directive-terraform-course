provider "aws" {
  region = "ap-south-1"  # Specify your AWS region
}

resource "aws_instance" "world" {
  ami           = "ami-00bb6a80f01f03502"  # Replace with your instance's AMI ID
  instance_type = "t2.micro"  # Replace with your instance type

  tags = {
    Name = "ImportedInstance"
  }
}

