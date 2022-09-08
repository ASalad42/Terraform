# IaC with Terraform 

![image](https://user-images.githubusercontent.com/104793540/189126425-2554fc30-88f7-4ef4-a691-0daa34521972.png)

## What is IaC and benefits

Infrastructure as Code evolved to solve the problem of environment drift in the release pipeline. The idea of Infrastructure as Code (IaC) was spurred on by the success of CI/CD. Infrastructure as Code (IaC) automates the provisioning of infrastructure, enabling your organization to develop, deploy, and scale cloud applications with greater speed, less risk, and reduced cost.

IaC is a key DevOps practice and is used in conjunction with continuous delivery.

- boosts productivity through automation
- Minimizing risk of human error (less manual taks)
- Increased efficiency in software development
- combat environment drift 
- Cost reduction
- Increase in speed of deployments
- Reduce errors 
- Improve infrastructure consistency
- Eliminate configuration drift


REF: https://apiumhub.com/tech-blog-barcelona/infrastructure-as-code-benefits-and-tools/

## Tools Available for IaC 

![image](https://user-images.githubusercontent.com/104793540/189090681-034f8119-7934-4dfa-b8d9-b31fafcd2800.png)


REF: https://www.redhat.com/en/topics/automation/what-is-infrastructure-as-code-iac
## What is Terraform and How it Works 

**Terraform is HashiCorp's infrastructure as code tool.** It lets you define resources and infrastructure in human-readable, declarative configuration files, and manages your infrastructure's lifecycle

![image](https://user-images.githubusercontent.com/104793540/189092077-a22b97c0-11a3-4624-ab09-dc1922205a59.png)

#### Benefits

- Terraform can manage infrastructure on multiple cloud platforms.
- The human-readable configuration language helps you write infrastructure code quickly.
- Terraform's state allows you to track resource changes throughout your deployments.
- You can commit your configurations to version control to safely collaborate on infrastructure.


### how to orchestrate with Terraform using IaC


### Installing terraform 

- https://chocolatey.org/install
- in powershell run the following command 
- `Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))`
- Install Terraform `choco install terraform`
- Check installation `terraform --version`
- Powershell ENV refresh command `refreshenv`

## Creating ec2 instance using Terraform 

securing aws keys while using terraform:

- edit the system environment variables
 
![image](https://user-images.githubusercontent.com/104793540/189106192-b9b302ac-a2c8-4072-be02-6262b5d205de.png)

- create main.tf file 
- who is cloud provider and region > terraform init
- terraform init 
- create block of code to launch ec2 server 

```
# who is the cloud provider

provider "aws" {

# within the cloud which part of world
# we want to use eu-west-1

    region = "eu-west-1"
}


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
```

- terraform plan - always do first to check syntax etc etc 
- terraform apply - launch ec2

![image](https://user-images.githubusercontent.com/104793540/189106442-d8736188-052f-47ba-a797-2c042e9b4bfb.png)

- terraform destroy > yes - deletes ec2
- attach pem file to ec2 created from terraform 
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair

![image](https://user-images.githubusercontent.com/104793540/189126851-2fe99d12-7348-460d-99d7-1e7162b85d04.png)

under heading off VPC virtual private cloud 

- vpc - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
- subnet - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
- igw - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/internet_gateway
