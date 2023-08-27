## PAUL SEIFER Interview Assignment project README.md

Project includes a simple web page that is containerized with nginx, shipped to ECR and exposed via ECS/Cloudformation. The ECR repo, ECS cluster and auxillaries (VPC, igw ELB etc) are created via Terraform/Cloudformation. The CI/CD pipeline is run by CircleCI.

To trigger the pipeline, first authorize access to your Github account in CircleCI and then clone this project:
```
git clone https://github.com/sheikh-0/mywebapp.git
```
Then create a branch and edit it, after that use `git add . && git commit -am "my edits" && git push` to trigger the build/deploy in CircleCI (after infrastructure has been successfully applied via Terraform in the step below).

## Prerequisites
### Set up required AWS resources
Builds of this project rely on AWS resources to be present in order to succeed. For convenience, the prerequisite AWS resources may be created using the terraform scripts procided in the `terraform_setup` directory.
1. Ensure [terraform](https://www.terraform.io/) is installed on your system.
2. Edit `terraform_setup/terraform.tfvars` to fill in the necessary variable values (an Amazon account with sufficient privileges to create resources like an IAM account, VPC, EC2 instances, Elastic Load Balancer, etc is required). (NOTE: It is a capital offence to commit this file to a public repository after it has been populated with your AWS credentials)
3. Use terraform to create the AWS resources
    ```
    cd terraform_setup
    terraform init
    # Review the plan
    terraform plan
    # Apply the plan to create the AWS resources
    terraform apply
    ```
4. You can run `terraform destroy` to destroy most of the created AWS resources.

### Configure environment variables on CircleCI
The following [environment variables](https://circleci.com/docs/2.0/env-vars/#setting-an-environment-variable-in-a-project) must be set for the project on CircleCI via the project settings page, before the project can be built successfully.


| Variable                       | Description                                               |
| ------------------------------ | --------------------------------------------------------- |
| `AWS_ACCESS_KEY_ID`            | Used by the AWS CLI                                       |
| `AWS_SECRET_ACCESS_KEY `       | Used by the AWS CLI                                       |
| `AWS_DEFAULT_REGION`           | Used by the AWS CLI. Example value: "us-east-1" (Please make sure the specified region is supported by the Fargate launch type)                          |
| `AWS_ACCOUNT_ID`               | AWS account id. This information is required for deployment.                                   |
| `AWS_RESOURCE_NAME_PREFIX`     | Prefix that some of the required AWS resources are assumed to have in their names. The value should correspond to the `aws_resource_prefix` variable value in `terraform_setup/terraform.tfvars`. 

### Nginx served web page code:

## Templates:

Put your templates/ html files in `templates` directory.

index.html:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>This is Pauls assignment web page</title>
</head>
<body>
    <h1>Hello {name}</h1>
    <h3>Have a great day!</h3>
</body>
</html>
```

