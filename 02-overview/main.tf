terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "example" {
  count         = var.instance_count
  ami           = "ami-0ddfba243cbee3768" # Ubuntu 20.04 LTS // ap-south-1
  instance_type = "t2.micro"
}

variable "instance_count" {
  description = "Number of instances to launch"
  type        = number
  default     = 1

}