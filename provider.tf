terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket = "argo-kubernetes-terraform"
    key    = "statefile"
    region = "eu-west-2"
  }
}

