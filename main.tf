
# who is the cloud provider

provider "aws" {

# within the cloud which part of world
# we want to use eu-west-1

    region = "eu-west-1"
}


# 

# init and download required packages 
# terraform init 


# create a block of code to launch ec2-server 

# which resources do we like to create 
resource "aws_instance" "app_instance" {   

# using which ami
    ami= "ami-0b47105e3d7fc023e"

# instance type
    instance_type = "t2.micro"

# do we need it to have public ip
    associate_public_ip_address = true

# how to name your instance 
    tags = {
        Name = "eng122_ayanle_terraform-app"
    }
# find out how to attach pem file 
    key_name = "eng122-ayanle1"
}


# git branch -M main 