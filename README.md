## PAUL SEIFER Interview Assignment project README.md

Project includes a simple Python Gunicorn based web application that is containerized, shipped to ECR and exposed via ECS/Cloudformation. The ECR repo, ECS cluster and auxillaries (VPC, igw ELB etc) are created via Terraform/Cloudformation. The CI/CD pipeline is run by CircleCI.

## Prerequisites
### Set up required AWS resources
Builds of this project rely on AWS resources to be present in order to succeed. For convenience, the prerequisite AWS resources may be created using the terraform scripts procided in the `terraform_setup` directory.
1. Ensure [terraform](https://www.terraform.io/) is installed on your system.
2. Edit `terraform_setup/terraform.tfvars` to fill in the necessary variable values (an Amazon account with sufficient privileges to create resources like an IAM account, VPC, EC2 instances, Elastic Load Balancer, etc is required). (It is not advisable to commit this file to a public repository after it has been populated with your AWS credentials)
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

# Python_webapp

A Pure Python Web Application Without using any FrameWork.


## Installation and Setup

1. install python 3.x
2. install requirements
`python -m pip install -r requirements.txt`
OR
`pip install -r requirements.txt`
3. if this did not worked than try `python -m pip install gunicorn`
4. run gunicorn server:
`gunicorn server:app --reload`
5. open the browser and go to the url which will apper
```bash
$ gunicorn server:app --reload
[2020-11-19 13:14:49 +0530] [14209] [INFO] Starting gunicorn 20.0.4
[2020-11-19 13:14:49 +0530] [14209] [INFO] Listening at: http://127.0.0.1:8000 (14209)
[2020-11-19 13:14:49 +0530] [14209] [INFO] Using worker: sync
[2020-11-19 13:14:49 +0530] [14212] [INFO] Booting worker with pid: 14212
```

## Templates

Put your templates/ html files in `templates` directory.

## Views

Put your views/ functions in `views.py` file


### App

Create a gunicorn web app using following function->

```python
def app(environ, start_response):
    #data = "Hello World!"
    data = views.home(environ)
    data = data.encode("utf-8")
    start_response(
        f"200 OK", [
            #("Content-Type", "text/plain"),
            ("Content-Type", "text/html"),
            ("Content-Length", str(len(data)))
        ]
    )
    return iter([data])
```

