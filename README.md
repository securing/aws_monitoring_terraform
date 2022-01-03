# Terraform scripts for fast setup of AWS monitoring services

### by [@_pkusik](https://twitter.com/_pkusik)

## Description
Easy to use terraform scripts with minimal requirement of configuration.  
For now it's possible to:
* Set up single account services & needed resources:
  * AWS Budgets (with email and/or SMS notification using SNS)
  * AWS CloudTrail (with option of encrypting the logs with CMK)
  * AWS Config
  * AWS GuardDuty

## Setup
0. Install Terraform - [instruction](https://learn.hashicorp.com/tutorials/terraform/install-cli)
1. Rename _example.tfvars_ file to the _terraform.tfvars_
2. Change options to your liking - choose which services to enable, change names of resources, add your AWS profile or region
3. Run the commands:
```bash
terraform init
terraform apply
```
Everything done!  
You are also free to look up into modules and copy fragments of them into your own Terraform scripts.

## ToDo

* Organizational deployments
* More AWS Services, like SecurityHub
* Support for multi-region deployments