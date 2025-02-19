terraform {
  # Assumes s3 bucket and dynamo DB table already set up
  # See /code/03-basics/aws-backend
  backend "s3" {
    bucket         = "devops-directive-tf-state-pre"
    key            = "06-organization-and-modules/consul/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

############################################################
##
## NOTE: if you are deploying this in your production setup
## follow the instructions in the github repo on how to modify
## deploying with the defaults here as an example of the power
## of modules.
##
## REPO: https://github.com/hashicorp/terraform-aws-consul
##
############################################################
module "consul-starter" {
  source  = "hashicorp/consul-starter/aws"
  version = "0.2.0"

  # Required Variables
  allowed_inbound_cidrs = ["10.0.0.0/16"]  # Adjust based on your network
  consul_version        = "1.14.4"         # Latest stable version, update if needed
  name_prefix           = "consul-cluster" # Meaningful prefix
  owner                 = "admin-user"     # Replace with your name or team name
  vpc_id                = "vpc-0a1b2c3d4e" # Use your actual VPC ID

  # Optional Variables (Modify if needed)
  acl_bootstrap_bool     = true
  consul_clients         = "3"
  consul_cluster_version = "0.0.1"
  consul_servers         = "5"
  enable_connect         = false
  instance_type          = "t3.medium"   # More cost-effective than "m5.large"
  key_name               = "my-key-pair" # Replace with your SSH key name
  public_ip              = false
}
