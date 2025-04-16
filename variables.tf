variable "region" {
  type        = string
  description = "The AWS region where all resources should be created"
  default     = "us-east-2"
}

variable "aws_access_key" {
  type        = string
  description = "AWS Access Key"
}

variable "aws_secret_key" {
  type        = string
  description = "AWS Secret Key"
}

variable "s3_bucket" {
  type        = string
  description = "name of the AWS S3 bucket to create and load the model"
}

variable "model_path" {
  type        = string
  description = "Local path to model zip file to upload to AWS S3"
}

variable "ami" {
  type        = string
  description = "Amazon Machine Image for EC2"
  default     = "ami-04f167a56786e4b09"
}

variable "instance_type" {
  type        = string
  description = "Instance type containing specifications for vCPU and memory"
  default     = "c7i.large"
}

variable "aws_key_pair_name" {
  type        = string
  description = "name of an ssh key pair generated in AWS and stored in AWS account"
}

variable "ip_address" {
  type        = string
  description = "local IP address to allow connection"
}

variable "vpc_cidr" {
  type        = string
  description = "cidr block for the VPC"
  default     = "10.0.0.0/16"
}

variable "cidr_public_subnet" {
  type        = list(string)
  description = "List of cidr blocks to use for public subnets"
  default     = ["10.0.0.0/24", "10.0.16.0/24", "10.0.32.0/24"]
}

variable "availability_zone" {
  type        = list(string)
  description = "List of availability zones for use in setting up subnets"
  default     = ["us-east-2a", "us-east-2b", "us-east-2c"]
}