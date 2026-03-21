# Maplewood Bakery — AWS VPC Infrastructure
**Project 1 | Beginner | Cloud Engineer Portfolio**

## Business Scenario
Maplewood Bakery is a small local bakery launching their first website for online orders.
This infrastructure provides a secure, isolated AWS environment with a public-facing
web server and a protected backend subnet for future database use.

## Architecture
- **VPC:** 10.0.0.0/16
- **Public Subnet:** 10.0.1.0/24 — Web server lives here
- **Private Subnet:** 10.0.2.0/24 — Database tier (future RDS)
- **Internet Gateway:** Connects VPC to public internet
- **Public Route Table:** Routes 0.0.0.0/0 → IGW
- **Private Route Table:** No internet route — locked down by design
- **Security Group:** HTTP (80), HTTPS (443), SSH (22/My IP only)

## Skills Demonstrated
- VPC design and CIDR planning
- Public/private subnet segmentation
- Internet Gateway configuration
- Route table design
- Security group rules (least privilege)
- Infrastructure as Code with Terraform

## Files
| File | Purpose |
|---|---|
| `main.tf` | All AWS resources |
| `variables.tf` | Input variable definitions |
| `outputs.tf` | Resource IDs output after apply |
| `terraform.tfvars` | Your environment values |

## How to Deploy
```bash
# 1. Install Terraform: https://developer.hashicorp.com/terraform/install
# 2. Configure AWS CLI with your credentials
aws configure

# 3. Clone and navigate to this repo
cd maplewood-bakery-vpc

# 4. Edit terraform.tfvars — add your IP address

# 5. Initialize Terraform
terraform init

# 6. Preview what will be created
terraform plan

# 7. Deploy
terraform apply

# 8. Destroy when done (avoid any charges)
terraform destroy
```

## Cost
**$0** — VPC, subnets, IGW, route tables, and security groups are all free.
No EC2 instances are deployed in this configuration.
