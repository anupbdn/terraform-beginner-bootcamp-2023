# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure

Our root module structure consists of following items:

```
  PROJECT_ROOT
  | 
  |- main.tf          # every terraform content
  |- variables.tf     # stores the structure of input variables
  |- terraform.tfvars # the data of variables we want to load into our terraform project
  |- providers.tf     # defined required providers and their configurations
  |- outputs.tf       # stores our outputs
  |- README.md        # required for root modules

```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and Input Variable

### Terraform Cloud Variables

In Terraform Cloud you can set two types of variables:
 - Environment Variables - this is like any other env variables we set for providers
 - Terraform Variables - this refers to input variable that is needed as parameter in code as tfvars file

### Loading Terraform Input Variables

[Terraform variables documentation](https://developer.hashicorp.com/terraform/language/values/variables)

We can use the `-var` flag to set an input variable or override any variable defined in tfvars file eg. `terraform -var user_uuid="my-uuid"`

### var-file flag

We can use the `-var-file` flag to set if we have lots of variables.Filename ending with `.tfvars` or `.tfvars.json` can be used as variable definition file 
eg. `terraform apply -var-file="testing.tfvars"`

### terraform.tfvars

It is a variable definition file where we can define variables needed for code.Terraform automatically loads `terraform.tfvars` variable definition file unlike other `.tfvars` files which needs `-var-file` flag to be specified.

### auto.tfvars

 `auto.tfvars`is a special file that Terraform automatically loads to populate input variable values. This file is used for setting default values for variables and can be particularly useful for sensitive information like API keys or secret values that you don't want to store directly in your Terraform configuration files.

### Order of terraform variables

Terraform loads variables in the following order :
- Environment variables
- terraform.tfvars file, if present.
- terraform.tfvars.json file, if present.
- *.auto.tfvars or *.auto.tfvars.json files, processed in lexical order of their filenames.
- -var and -var-file options on the command line, in the order they are provided.


