terraform {
	required_version = ">= 1.5.0"
	required_providers {
		helm = {
			source = "hashicorp/helm"
			version = "~> 2.12"
		}
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
