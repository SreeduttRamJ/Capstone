terraform {

  required_version = ">= 1.0.0"

}



# Placeholder resource-free configuration for CI planning demo.

# You can later add real providers/resources when credentials are available.

locals {

  project_name = var.project_name

}



output "project_name" {

  value = local.project_name

}
