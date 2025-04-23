data "external" "latest_commit" {
  program = ["bash", "${path.module}/latest_commit.sh"]
}

locals {
  labels = {
    "traefik.enable"                           = "true"
    "traefik.docker.network"                   = "services"
    "traefik.http.routers.estillore_dev.entryPoints" = "web"
    "traefik.http.routers.estillore_dev.rule"        = "Host(`${var.service_hostname}`)"
  }
  docker_image_tag = data.external.latest_commit.result["commit_hash"]
}

resource "docker_image" "estillore_dev" {
  name         = "${var.service_hostname}:${local.docker_image_tag}"
  keep_locally = true

  build {
    context = "../"
    dockerfile = "Dockerfile"
    tag = ["${var.service_hostname}:${local.docker_image_tag}"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "docker_container" "nginx" {
  name    = var.service_hostname
  image   = docker_image.estillore_dev.image_id
  restart = "always"

  dynamic "ports" {
    for_each = terraform.workspace == "local" ? [1] : []

    content {
      internal = 80
      external = 8083
      protocol = "tcp"
    }
  }

  networks_advanced {
    name = "services"
  }

  dynamic "labels" {
    for_each = local.labels
    content {
      label = labels.key
      value = labels.value
    }
  }
}
