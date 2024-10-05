# static-website-with-s3
Infra Code for provisioning static web hosting with s3 bucket behind cdn(cloud front), the infra structure as shown in the bellow diagram.

![img](img/infra-dgm.drawio.png)

## Authentication
Use environment variables
```bash
export AWS_ACCESS_KEY_ID="MYACCESSKEY"
export AWS_SECRET_ACCESS_KEY="MYSECRET"
export AWS_REGION="ap-southeast-2"
```
## Something not covered in Terraform
You have to get the TLS/SSL certificate ready before applying this terraform code.
> Notice: According to the convention of aws, your certified domain name should be as some as the name of your s3 bucket
## How to apply
After exporting credentials to env, run the following command
```bash
# Init terraform local files
terraform init
# Display desired states of resources
terraform plan
# Apply the infra changes
terraform apply
```
