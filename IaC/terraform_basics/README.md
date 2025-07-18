* Terraform mainly does server provisioning and it provides few basic features to configure software but typically do server provisioning

* In main.tf we run all the configurations. terraform init does the backend initialization

* Setting up the environment variable to access the AWS access keys
```
    export AWS_ACCESS_KEY_ID=key
    export AWS_SECRET_ACCESS_KEY=secret_key
```

* Amazon S3(simple storage service) bucket is storage for the internet. Its like providing a key and store the file. It has high durability and availability

* Creating S3 bucket using terraform to store the file and resource in tf is object managed in the cloud. To use resource we need to give type of the resource+provider name and name of the terraform to access the type of resource(internal tf name)

* Plan(terraform plan) command would tell us what would happen in tf like dry run and second command is execution (terraform apply)

* If there are no changes performed to tf file and execution of terraform apply command will not perform any action

* Desired state is informing what we need. Known state is result of previous execution(terraform.tfstate) and actual state is state in AWS it can be any cloud server. Therefore tf is declarative

* When terraform apply is done it makes desired state as actual state

* terraform console command gives info about configuration. We can have output variabled in the tf file

* terraform plan will store the output into a file. terraform plan -out iam.tfplan and apply the plan using terraform apply iam.tfplan

* Once the bucket is created bucket name cannot be changed(aws_iam_user) but IAM user name can be changed(my_users). Use terraform apply -target="aws_iam_user.my_iam_user" command to update the username instead of deleting and creating a new user

* terraform.tfstate.backup contains the state before the terraform apply command execution and terraform.tfstate contains the state after the terraform apply command execution. Changes should not be applied to terraform.tfstate file directly

* terraform.tfstate file is important because it contains the mapping from terraform name of the resource to aws identifier of that resource . So without that tf will not get the known state

* Commiting terraform.tfstate/terraform.tfstate.backup and .terraform folder in git is bad idea because it keeps the data unencrypted. So add these files in .gitignore or can be kept in cloud to fetch the known state

* Different configuration inside main.tf can be separated and kept in different files ex: output variables etc... Any number of .tf files inside tf folder will be considered/executed when we do terraform apply/plan

* Its always good to destroy tf after creating it.Take it as a cycle.tf commands will first refreshes the state and then go ahead and executed the config instructions 