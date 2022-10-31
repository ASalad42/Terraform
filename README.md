# IaC with Terraform 


![image](https://user-images.githubusercontent.com/104793540/197299626-af56ea45-e547-49eb-a2f8-fe005f932303.png)
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

Terraform creates and manages resources on cloud platforms and other services through their application programming interfaces (APIs). Providers enable Terraform to work with virtually any platform or service with an accessible API.

The core Terraform workflow consists of three stages:

- **Write:** You define resources, which may be across multiple cloud providers and services. For example, you might create a configuration to deploy an application on virtual machines in a Virtual Private Cloud (VPC) network with security groups and a load balancer.
- **Plan:** Terraform creates an execution plan describing the infrastructure it will create, update, or destroy based on the existing infrastructure and your configuration.
- **Apply:** On approval, Terraform performs the proposed operations in the correct order, respecting any resource dependencies. For example, if you update the properties of a VPC and change the number of virtual machines in that VPC, Terraform will recreate the VPC before scaling the virtual machines.

![image](https://user-images.githubusercontent.com/104793540/189092077-a22b97c0-11a3-4624-ab09-dc1922205a59.png)

#### Benefits

- Terraform can manage infrastructure on multiple cloud platforms.
- The human-readable configuration language helps you write infrastructure code quickly.
- Terraform's state allows you to track resource changes throughout your deployments.
- You can commit your configurations to version control to safely collaborate on infrastructure.

### IAC (infrastructure orchestration = terraform) & Configuration Management (ansible) = Friends 

**Infrastructure as Code (IaC)** and **Configuration Management (CM)** go hand and hand when it comes to cloud computing. IaC manages infrastructure using a descriptive model. Infrastructure includes networks, virtual machines, load balancers, to name a few. **An IaC model produces the same environment every time it is applied.**

Configuration Management (CM) **maintains the consistency of an application’s performance, as well as its functional and physical inputs along with requirements, overall design, and operations throughout the lifespan of the product.**

| Infrastructure as Code  | Configuration Management |
| ------------- | ------------- |
| Terraform  | Ansible |
| AWS CloudFormation | AWS OpsWorks |
| Azure Resource Manager | Microsoft System Center Configuration Manager |
| Google Cloud Deployment Manager | Puppet|
|  | Chef |
|  | Saltstack |


REF: https://blog.datanextsolutions.com/infrastructure-as-code-iac-and-configuration-management-cm-583be1687c6d

![image](https://user-images.githubusercontent.com/104793540/197222488-c908eb92-3425-42b2-acb9-84d69485e33e.png)

 Combining Terraform and CM tools. Terraform deploy infrastructure initially and Ansible installs and updates software:
 
 ![image](https://user-images.githubusercontent.com/104793540/197298304-3759c48c-425f-4a42-b4db-63e3a9df4719.png)

### Installing terraform 

- https://chocolatey.org/install
- in powershell run the following command 
- `Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))`
- Install Terraform `choco install terraform`
- Check installation `terraform --version`
- Powershell ENV refresh command `refreshenv`

## Creating ec2 instance using Terraform 

https://registry.terraform.io/providers/hashicorp/aws/latest/docs

Authentication and Configuration

Configuration for the AWS Provider can be derived from several sources, which are applied in the following order:
- Parameters in the provider configuration
- Environment variables
- Shared credentials files
- Shared configuration files
- Container credentials
- Instance profile credentials and region

This order matches the precedence used by the AWS CLI and the AWS SDKs.

Environment variables:
securing aws keys while using terraform:

- edit the system environment variables
 
![image](https://user-images.githubusercontent.com/104793540/189106192-b9b302ac-a2c8-4072-be02-6262b5d205de.png)

### Write, Plan, Apply 
- create main.tf file 
- detail who is the cloud provider and region > then `terraform init`
- Aim: create block of code to launch ec2 server 

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

- `terraform plan` - always do first to check syntax
- `terraform apply` - launch ec2

![image](https://user-images.githubusercontent.com/104793540/189106442-d8736188-052f-47ba-a797-2c042e9b4bfb.png)

- `terraform destroy` > yes - deletes ec2
- attach pem file to ec2 created from terraform 
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair

![image](https://user-images.githubusercontent.com/104793540/189126851-2fe99d12-7348-460d-99d7-1e7162b85d04.png)

#### Commands 

- `terraform init` in the directory that you've made the 'main.tf' file
- `terraform plan` checks code, always do first to check your code before actually launching whatever your doing. Using the whole 'measure twice, cut one' methodology
- `terraform apply` to launch your instance, as configured in your main.tf file.
- `terraform destroy` to delete all
- for specfific resource use Terraform destroy -target resource type + local resource name i.e `Terraform destroy -target aws_instance.myec2`
- `terraform refresh`
- `terraform init -upgrade` version matches to latest
- `terraform fmt` sorts format
- `terraform validate` checks syntax 

Note: yes in the commandline, when prompted (usually with Terraform plan & terraform apply)

### EC2 Instance with Configured: VPC,Subnets,Internet Gateway and Route Tables
- Perform the steps below in main.tf in order to successfuly launch of EC2 instance with configured network settings
- Create VPC
- Create public (app) and private (db) subnets within vpc. Used: 10.0.11.0/24 / 10.0.22.0/24 respectively.
- Interent gateway must be provisioned witin VPC.
- Routes tables for both subnets must be created.
- Association for subnets the route tables must be performed.
- Create security groups for ingress and egress routes.
- Create the EC2 instance within the VPC.


- vpc - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc

![image](https://user-images.githubusercontent.com/104793540/189158733-c9e4c8bf-1544-41d7-847e-8b18e28e242c.png)

- subnet - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet

![image](https://user-images.githubusercontent.com/104793540/189158887-8530169f-38ce-4aa5-9b1e-f7f3318c6b4b.png)

- igw - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/internet_gateway


```

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
    Name = "ayanle-terra-ig"
  }
}
# create public subnet

resource "aws_subnet" "ayanle_app_sn" {
	vpc_id = aws_vpc.ayanle_terraform_vpc.id
	cidr_block = "10.0.3.0/24"
	map_public_ip_on_launch = "true"  

	tags = {
		Name = "terra_ayanle_app"
	}

 }

# route table 
resource "aws_route_table" "public-app" {
  vpc_id = aws_vpc.ayanle_terraform_vpc.id

    tags = {
		Name = "terra_ayanle_rt"
	}
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

```

## create variable.tf file for abstraction

To minimise displaying any potential data, refactor the main.tf script by creating a new variable.tf script defining all the key parameters so only necessary information is displayed. The variable script must be added .gitignore file.


## Notes

### Terraform State file .tfstate
- terraform stores the state of the infastructure that is being created from the TF files
- this state allows terraform to map real world resource to your existing configuration (done behind the scenes in the state file) 
- the exact running data of the deployed resources are kept in the .tfstate file!
- best practice to avoid touching this file and making changes (also store backup of this file)

![image](https://user-images.githubusercontent.com/104793540/197756836-55d622fe-d6e6-4784-9dfb-00b8f8c033ac.png)


### Desired state and current state 
- terraform's primary function is to create, modify, and destroy infastructure resources to match the desired state described in a terraform configuration 

![image](https://user-images.githubusercontent.com/104793540/197759793-4bf55578-cb8f-4533-a30d-f4b021f43a47.png)

- The current state is the actual state of a resource that is currently deployed i.e t2.medium 
- Terraform tries to ensure that the deployed infrastructure is based on the desired state. If there is a difference between the two, terraform plan presents a description of the changes necessary to achieve the desired state. 
- then terraform apply changes back to desired i.e from t2.medium to t2.micro and change visible on aws console!
- in config file, recommended to detail all the key things you need for your resource (so always matches your desired state) and whatever you specifiy here will be part of the desired state so if any changes occour here. Terraform plan will not show you details to revert this change. 


**Provider versioning:** For production use, you should constrain the acceptable provider versions via configuration, to ensure that new versions with breaking changes will not be automatically installed

There are multiple ways of specifying the version of a provider:

![image](https://user-images.githubusercontent.com/104793540/197775382-b2d89738-3985-4146-8544-27307e96f198.png)

- Not recommended to use ~>x.0 for production as later versions may not work with your application
- Dependency Lock file has contrained version so if someone tries to configuration and terraform init it will not allow. 

### Read, Generate, Modify Configs
- always use different folders for use cases to be more systematic and for easier revisit 

#### Attributes & Output values:
- Terraform has the capability to output the attribute of a resource with the output values.
```
resource "aws_eip" "lb" {
  vpc      = true
}

output "eip" {
  value = aws_eip.lb.public_ip
}
```
- `terraform apply` > outputs will be displayed (**very useful feature** as it allows you see without going to console)(value = resourcename.nameigive.attribute)(in documentation check attributes reference)(leave blank for all attributes)
- **An outputed attributes can not only be used for the user reference but it can also act as an input
to other resources being created via terraform**
-  for example - After EIP gets created, it’s IP address should automatically get whitelisted in the security group.

#### Cross-Resource Attributes:
- EIP & EC2 example > auto attach eip to ec2 on launch > aws_eip_association 
```
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.myec2.id
  allocation_id = aws_eip.lb.id
}
```
#### Terraform Variables 
more static code = more work so use variables to save time and account for change in the future 

in variables.tf file:
```
variable "vpn_ip" {
  default = "116.50.30.50/32"
}
```
- during update only change variable.tf file instead of going into working file and manually changing all.

in working file:
```
resource "aws_security_group" "var_example" {
  name        = "ayanle-variables"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpn_ip]
  }

```

Variables in Terraform can be assigned values in multiple ways. Some of these include:
- Environment variables: `export TF_VAR_instancetype="t2.nano" then  echo $TF_VAR` (load new cmd prompt)
- Command Line Flags: `terraform plan -var="instancetype=t2.small"`
- From a File (terraform.tfvars): `instancetype="t2.micro"` (**prod env**) (`terraform plan` will use this and overwrite the default)
- Variable Defaults:  `variable "instancetype" { default = "t2.micro"}` or leave blank and insert during prompt. (**prod env**)

#### Data types for variables
![image](https://user-images.githubusercontent.com/104793540/198274631-30ffd78d-f8cc-4b7d-a931-822f69fab040.png)

variables.tf
```

variable "elb_name" {
  type = string
}

variable "az" {
  type = list
}

variable "timeout" {
  type = number
}
```

terraform.tfvars
```
elb_name="myelb"
timeout="400"
az=["us-west-1a","us-west-1b"]
```

#### Count 
- With the count parameter, we can simply specify the count value and the resource can be
scaled accordingly.(all same name though)
- count.index allows us to fetch the index of each iteration in the loop. combine with variable
```
variable "elb_names" {
  type = list
  default = ["dev-loadbalancer", "stage-loadbalanacer","prod-loadbalancer"]
}
resource "aws_iam_user" "lb" {
  name = var.elb_names[count.index]
  count = 3
  path = "/system/"
}
```

#### Terraform Functions 
documentation: built-in functions section 

- `terraform console`

#### Data Source
- Data sources allow data to be fetched or computed for use elsewhere in Terraform
configuration.
- A data source is defined under the data block.

```
data "aws_ami" "app_ami" {
  most_recent = true
  owners = ["amazon"]


  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "instance-1" {
    ami = data.aws_ami.app_ami.id
   instance_type = "t2.micro"
}
```
####
####
