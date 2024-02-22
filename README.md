### README
``` This application can be test on [here](http://a57154d538ab74a3f97cfa7e997e2346-84494540.eu-west-1.elb.amazonaws.com:3000) ```

```The application was deployed with AWS EKS```

```Infrastructure was provisioned with terraform and the script can be found in the terraform directory. The terraform state is managed locally ```

```The github user were provisioned with terraform```

### Stacks Used
 - AWS EKS
 - MongoDB
 - Github Actions
 - Helm Chart
 - Nodejs
 - Docker
 - Kubernetes

### Development workflow

The following local workflow enables rapid testing and development.

- `install aws cli` - install aws cli (optional if already set up) 
- `aws configure ` - configure your aws profile with your access key and secret key (optional if already set up) 
- Edit `~/.aws/config ` - you may need to also configure your aws config file (optional if already set up) 
- instructions can be found here https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html    
- `aws sts get-caller-identity` - to verify that you assumed the IAM role by running this command

### CLI command
- cd terraform (Assuming Terraform is installed locally)
- terraform init
- terraform fmt
- terraform validate
- terraform plan
- terraform apply --auto-approve

### Github Secrets to create 

- AWS_ACCESS_KEY_ID
- AWS_ACCOUNT_ID
- AWS_ROLE_ARN
- AWS_SECRET_ACCESS_KEY

### Deploy Code
- git push to github (workflow will be triggered)
