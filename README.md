### Explanation:
* Provider Configuration: Specifies AWS as the provider and sets the region.
* Local Variables: A map env_config holds configurations for each environment.
* Workspace Detection: Uses terraform.workspace to determine the current workspace.
* Resource Definitions: S3 bucket and EC2 instance are created with names and types based on the current workspace.
* Outputs: Outputs the bucket name and instance ID for reference.

### Usage:
1. Initialize Terraform: terraform init
2. Create a workspace for each environment:
terraform workspace new dev
terraform workspace new qa
terraform workspace new prod
3. Apply the configuration for each environment:
terraform workspace select dev && terraform apply
terraform workspace select qa && terraform apply
terraform workspace select prod && terraform apply
This setup allows you to manage resources across different environments efficiently using Terraform workspaces.
