* Refer https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user document to know about all configuration related to AWS IAM user

* terraform console give the info about state, name, path of the terraform. Use exit to exit from tf console

* terraform validate check if the tf files syntax is correct and terraform.fmt will check the format and does the formatting if its not formated correctly. terraform show will display the human readable output of current state

* Refer https://developer.hashicorp.com/terraform/cli/commands/apply for tf apply usage. tf will store its state in cloud so any errors made will not be updated in cloud and errors can be recovered from cloud

* If there any variabled without any default values tf will ask for a value. Variable value can be override by exporting the variable with different value. Can also be provided using -var="my_iam_user_prefix=MY_VALUE_FROM_COMMAND_LINE" from commandline while doing terraform apply

* Variables can also be stored in the .tfvarsfile and can be passed using command line. terraform apply --var-file="some-name.tfvars"
