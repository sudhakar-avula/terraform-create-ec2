variable "aws_region" {
    description = "AWS region for EC2 instance"
    type = string
}

variable "ami_id" {
    description = "AMI ID for the EC2 instance"
    type = string
}

variable "instance_type" {
    description = "EC2 instance type"
    type = string
}

variable "ec2_name" {
    description = "Name of EC2 instance"
    type = string
}