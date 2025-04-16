# terraform-aws-vm
This repository sets up a Virtual Machine with SSH access in AWS using Terraform or OpenTofu

# Set-up
1. Install Terraform or OpenTofu
   https://developer.hashicorp.com/terraform/install

   https://opentofu.org/docs/intro/install/

2. Sign-up for AWS Account

3. Create non-root user in IAM with Access and Secret Keys

4. Create an SSH key-pair in AWS and associate with non-root user account

# Create terraform.tfvars
Based on the entries in variables.tf, populate a file providing required information (anything without a default keyword)

```
aws_access_key    = "XXXXXX"
aws_secret_key    = "XXXXXX"
s3_bucket         = "<name of S3 Bucket>"
model_path        = "/path/to/model.zip"
aws_key_pair_name = "<name of ssh keypair >"
ip_address        = "<your ip address or 0.0.0.0/0>"
```

**NOTE**: you can update the Amazon Machine Image for different operating systems. This defaults to Ubuntu 24.04 LTS.
          you can also update and likely will want to update the instance_type. The default c7i.large has 2 vCPU and 4GB ram


# Deploy to AWS
```bash
terraform init
```

```bash
terraform apply
```

type "yes" when prompted

When complete and everything is deployed the command to ssh into the VM will be written to the terminal.

when finished, be sure to clean up after yourself to not keep incurring charges

```bash
terraform destroy
```

**NOTE** all terraform commands can be replaced with tofu (if using OpenTofu)

# Reminder
When deciding to use OpenTofu vs Terraform, make sure to check out the licensing policy
