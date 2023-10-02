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

## Dealing with Configuration Drift

### What to do when you lose terraform state file?

You will have to the aws resource which is created and use import block to create state files for the resources.
Note: Not all resources supports Import

#### Fix Missing Resources with Terraform Import

Terraform maintains `terraform.tfstate` as its source of truth , Hence state file is a very important file to maintain.If there is a case of manual configuration changes or accident configuration change use `import` block to import existing infrastructure resources into Terraform. Below example is a way to import S3 :
`terraform import aws_s3_bucket.bucket bucket-name`

[Terrafom Import](https://developer.hashicorp.com/terraform/cli/import)

[S3 Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

#### Fix Manual Configuration

If an engineer Delete or Modify any terraform created resource through clickops by mistake or for any need. This can be fixed / recreated by running the `terraform apply` again . This is possible because terraform always refers state file and it fixes any configuration drift happened.

## Terraform Modules

### Terraform Module Structure

It is recommended to place modules in a `modules` directory when developing modules locally

### Module Sources

Using the source we can import the module from various places eg:
- locally
- Github
- Terraform registry

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
}
```

### Passing Input Variables

We can pass input variables to the module.All the variables should be declared in its own variable.tf (module path)

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```
[Terraform Module Documentation](https://developer.hashicorp.com/terraform/language/modules/sources#local-paths)

## Working with Files in Terraform

### Fileexists function 

This is a built in function of Terraform that checks whether a file exists or not . It is used for validation as below :

```tf
validation {
    condition     = fileexists(var.error_html_filepath)
    error_message = "The provided path for error.html does not exist."
  }
```

### Filemd5

This is used to track any file change and terraform know while doing a plan otherwise file content change cannot be verified by Terraform .

{filemd5 documentation}(https://developer.hashicorp.com/terraform/language/functions/filemd5)

### Path Variable

Terraform provides few path variables to handle filesystem . Variable `path` allows us to reference local path of modules:

- path.module - It is the filesystem path of the module where the expression is placed
- path.root - It is the filesystem path of the root module of the configuration

```tf
resource "aws_s3_object" "error_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "error.html"
  source = "${path.root}/public/error.html"
}
```

### Terraform Locals

Local values can be helpful to avoid repeating the same values or expressions multiple times in a configuration.

```tf
locals {
  s3_origin_id = "myS3Origin"
}
```

[Local Variable](https://developer.hashicorp.com/terraform/language/values/locals)

### Terraform Data Sources

Data sources allow Terraform to use information defined outside of Terraform, defined by another separate Terraform configuration, or modified by functions.

For example we can get aws account id using below data resource 

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```

[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

### Working with JSON

We use jsonencode to encode a given value to a string using JSON syntax.

[jsonencode documentation](https://developer.hashicorp.com/terraform/language/functions/jsonencode)

### Changing the Lifecylce of Resources

[Meta Arguments of Lifecycle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

### Terraform Data

The terraform_data resource is useful for storing values which need to follow a manage resource lifecycle, and for triggering provisioners when there is no other logical managed resource in which to place them.

[terraform_data resource](https://developer.hashicorp.com/terraform/language/resources/terraform-data)