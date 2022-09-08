
# who is the cloud provider

provider "aws" {

# within the cloud which part of world
# we want to use eu-west-1

    region = "eu-west-1"
}


# add vpc 
resource "aws_vpc" "ayanle_terraform_vpc" {
	cidr_block = "10.0.0.0/16"
	instance_tenancy = "default"

	tags = {
		Name = "ayanle-terraform-vpc"
	}
}

# internet gateway 
resource "aws_internet_gateway" "app-gw" {
  vpc_id = aws_vpc.ayanle_terraform_vpc.id

  tags = {
    Name = "main"
  }
}
# create public subnet

resource "aws_subnet" "ayanle_app_sn" {
	vpc_id = aws_vpc.ayanle_terraform_vpc.id
	cidr_block = "10.0.3.0/24"
	map_public_ip_on_launch = "true"  

	tags = {
		Name = "tr_ayanle_app"
	}

 }

# route table 
resource "aws_route_table" "public-app" {
  vpc_id = aws_vpc.ayanle_terraform_vpc.id

}
# subnet association

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.ayanle_app_sn.id
  route_table_id = aws_route_table.public-app.id
}

# init and download required packages 
# terraform init 


# create a block of code to launch ec2-server 

# which resources do we like to create 
resource "aws_instance" "app_instance" {   

# using which ami
    ami= "ami-082ca05f0b58358b8"

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