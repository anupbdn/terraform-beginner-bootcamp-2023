# Terraform Beginner Bootcamp 2023 - Week 0

## Table of Contents

- [Semantic Versioning](#semantic-versioning)
- [Install Terraform CLI](#install-terraform-cli)
    - [consideration for linux distribution](#consideration-for-linux-distribution)
    - [Refactoring into Bash Scripts](#refactoring-into-bash-scripts)
    - [Shebang Considerations](#shebang-considerations)
    - [Execution Considerations](#execution-considerations)
    - [Linux File Permission Considerations](#linux-file-permission-considerations)
- [GitPod Lifecycle](#gitpod-lifecycle-before-init-command)
- [Working with Env Vars](#working-with-env-vars)
    - [Setting and Unsetting Env Vars](#setting-and-unsetting-env-vars)
    - [Printing Vars](#printing-vars)
       - [Scoping of Env Vars](#scoping-of-env-vars)
       - [Persisting Env Vars in Gitpod](#persisting-env-vars-in-gitpod)
- [AWS CLI Installation](#aws-cli-installation)
- [Terraform Basics](#terraform-basics)
    - [Terraform Registry](#terraform-registry)
    - [Terraform Console](#terraform-console)
      - [Terraform Init](#terraform-init)
      - [Terraform Plan](#terraform-plan)
      - [Terraform Apply](#terraform-apply)
      - [Terraform Destroy](#terraform-destroy)
    - [Terraform Lock Files](#terraform-lock-files)
    - [Terraform State Files](#terraform-state-files)
    - [Terraform Directory](#terraform-directory)
- [AWS S3 bucket Naming](#aws-s3-bucket-naming)
- [Issues with Terraform login](#issues-with-terraform-login-with-gitpod)








## Semantic Versioning

This project is going to use semantic versioning for its tagging.
[semver.org](https://semver.org/)


_created branch from issue directly_

The general format:

 **MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install Terraform CLI
The Terraform  CLI installation can change with new versions due to this make sure we always refer the official documentation for the latest installation steps.

- [Terraform Installation](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Consideration for Linux Distribution

This project is built against ubuntu.
It is always a best practice to check what linux distribution you are working on before any installation.

[How to check Linux Flavour](https://www.tecmint.com/check-linux-os-version/)

Example of checking os version:

```
$ cat /etc/os-release

PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Refactoring into Bash Scripts

While fixing installation of Terraform , we came into a problem of gpg deprecation , Hence it came into our notice of converting the installation into a bash script with that way we can fully automate the installation of Terraform and aws cli

 This bash script [./bin/install_terraform_cli](./bin/install_terraform_cli) will automate the installation of terraform cli and aws cli

- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy.
- This makes life easier to debug and execute Terraform CLI installation manually if needed.
- This also make the installation portable for other projects

### Shebang Considerations

A shebang specifies that the script should be executed using bash shell. eg. `#!/usr/bin/env bash`

[Shebang](https://en.wikipedia.org/wiki/Shebang_(Unix))

### Execution Considerations

We need to use the `./` to execute a bash script

eg. `./bin/install_terraform_cli`

If we are using a task to execute bash script like we use it in .gitpod.yml we need to point the script to a program to interpret it.

eg. `source ./bin/install_terraform_cli`

### Linux File Permission Considerations

Inorder to make our scripts to be executable , we need to change file permission in linux as executable.

```sh
chmod 777 ./bin/install_terraform_cli
```

 or

 ```sh
  chmod u+x ./bin/install_terraform_cli
```
[linux file permission](https://en.wikipedia.org/wiki/Chmod)

## GitPod Lifecycle (Before, Init, Command)

We need to be careful when using Init in the task as gitpod uses before as priority and we have a chance of skipping Init according to [gitpod workflow](https://www.gitpod.io/docs/configure/workspaces/tasks)

## Working with Env Vars

We can list environment variables usinh `env` command

we can filter out env vars using grep `env | grep GITPOD`

### Setting and Unsetting Env Vars

We can set by using `export HELLO='world'`

We can unset using `unset HELLO`

We can set env var temporarily by running as below :

```sh
HELLO='world' ./bin/print_message
```

Within a bash script we can set env without writing export eg.

```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```

### Printing Vars

We can print using command eg. `echo $HELLO`

#### Scoping of Env Vars

When you open up new besh terminals , It will not be aware of env vars in another window

If you want to persist in another bash terminals . You will have to set in bash profiles . eg. `.bash_profile`

#### Persisting Env Vars in Gitpod

we can persist env vars into gitpod by storing them in Gitpod secrets storage.

```
gp env HELLO='world'
```

All future workspaces launched will set the env vars for all bash terminals opened in those workspaces.

You can also set en vars in the `.gitpod.yml` but this can only contain non-sensitive env vars.

## AWS CLI Installation

AWS cli is installed using bash script [./bin/install_aws_cli](./bin/install_aws_cli)

Refer AWS documentation for installation [AWS CLI installation](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

We can set env vars for aws account as per [AWS CLI env vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

we can also set it as global env vars as below :

```sh
gp env AWS_ACCESS_KEY_ID='AKIAIOSFODNN7EXAMPLE'
gp env AWS_SECRET_ACCESS_KEY='wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY'
gp env AWS_DEFAULT_REGION='eu-west-1'
```

we can check whether aws cli is installed by using below command :

```sh
aws sts get-caller-identity
```
If the authentication is successful we will get below output:

```json
{
    "UserId": "AIDAVL7OYZE3DK45CEJVS",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/terraform_bootcamp"
}
```

## Terraform Basics

### Terraform Registry

Terraform sources their providers and modules from the terraform registry. Always make sure that we refer documentation of providers which is located at [registry.terraform.io](https://registry.terraform.io/)

- **Providers** are a logical abstraction of an upstream API. They are responsible for understanding API interactions and exposing resources.
- **Modules** are self-contained packages of Terraform configurations that are managed as a group.
[Random Provider](https://registry.terraform.io/providers/hashicorp/random/latest/docs)

### Terraform Console

We can see a list of all the terraform commands by simply typing `terraform`

#### Terraform Init

The Terraform command `terraform init` initializes a working directory containing Terraform configuration files. This is the first command that should be run after writing a new Terraform configuration or cloning an existing one from version control.

#### Terraform Plan

The Terraform command `terraform plan` creates an execution plan, which lets you preview the changes that Terraform plans to make to your infrastructure. Refer [documentation](https://developer.hashicorp.com/terraform/cli/commands/plan)

#### Terraform Apply

The Terraform command `terraform apply` executes the actions proposed in a Terraform plan.When you run this command it will prompts you to approve `yes or no` before execution . You can bypass this prompt by auto approving using the command `terraform apply --auto-approve` . Refer [documentation](https://developer.hashicorp.com/terraform/cli/commands/apply)

#### Terraform Destroy

The Terraform command `terraform destroy` destroys/ deletes resources created using `terraform apply` previously.

### Terraform Lock Files

A Terraform configurations may refer to two kind of external dependencies Providers and Modules.Terraform must determine which versions of those dependencies are potentially compatible with the Project.
`.terraform.lock.hcl` contains the locked versioning for the providers or modules that should be used.Hence Terraform lock file **should be committed** to your version control system.

### Terraform State Files

Terraform stores information about your infrastructure in a state file. This state file keeps track of resources created by your configuration and maps them to real-world resources.

`terraform.tfstate`  file is used to store all the infrastructure details.This file **should not be committed** in your Version Control System. This can contain sensitive data.

`terraform.tfstate.backup` is the previous version of terraform state.

### Terraform Directory

`.terraform` directory contains binaries of terraform providers.

### AWS S3 bucket Naming

AWS has naming rules for a S3 bucket , Be careful while using any random modules to create a S3 bucket name as AWS rules should be followed or else you will get error when you do terraform apply.

### Issues with Terraform login with Gitpod

Inorder to use **Terraform Cloud** as your place to store your terraform state file , we have to first authenticate our terminal to terraform cloud. That can be done from the terminal with 
command `terraform login`

Terraform will ask an API token to be created and stored at `/home/gitpod/.terraform.d/credentials.tfrc.json`

Manually create or enter the API token when prompted as below :

```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "MY TOKEN"
    }
  }
```
Bash script [./bin/generate_tfrc_credentials](./bin/generate_tfrc_credentials) automates the json format and place it in the required folder `/home/gitpod/.terraform.d/credentials.tfrc.json`