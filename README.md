# Basic flow
![Alt text](./flow.png?raw=true "Basic flow")

# Prerequisites
The Terraform CLI (1.4.4+) installed.
The AWS CLI installed.
AWS account and associated credentials that allow you to create resources.

When you create a new configuration — or check out an existing configuration from version control — you need to initialize the directory with terraform init.
```bash
  terraform init
```

Format your configuration. Terraform will print out the names of the files it modified, if any
```bash
  terraform fmt
```

You can also make sure your configuration is syntactically valid and internally consistent by using the terraform validate command.
```bash
  terraform validate
```

Apply the configuration now with the terraform apply command.
```bash
  terraform apply
```