terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.31"
    }
  }

  backend "local" {
    path = "/home/yatharth-chandel/.terraform-state/platform-infra/terraform.tfstate"
  }
}

provider "kubernetes" {
  config_path = "${path.module}/kubeconfig"
}
