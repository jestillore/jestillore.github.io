terraform {
  required_version = "1.5.7"

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }

    archive = {
      source  = "hashicorp/archive"
      version = "2.7.0"
    }

    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }

    time = {
      source  = "hashicorp/time"
      version = "0.12.1"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}
