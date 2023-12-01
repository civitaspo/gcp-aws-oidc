terraform {
  required_version = "1.6.3"

  backend "local" {}

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.4.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "5.4.0"
    }
  }
}

provider "google" {}
provider "google-beta" {}
