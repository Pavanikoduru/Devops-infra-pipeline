terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

provider "local" {}
provider "null" {}

# Example: create a dummy file
resource "local_file" "sample" {
  content  = "Hello from Terraform!"
  filename = "${path.module}/hello.txt"
}

# Example: run a shell command to get cluster nodes
resource "null_resource" "kubectl_nodes" {
  provisioner "local-exec" {
    command = "kubectl get nodes"
  }
}

output "file_path" {
  value = local_file.sample.filename
}

