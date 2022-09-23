job "explorer_app" {
  datacenters = ["dc1"]

  group "roulette_app" {
    count = 1

    restart {
      attempts = 2
      delay    = "25s"
    }

    update {
      max_parallel     = 1
      min_healthy_time = "30s"
      healthy_deadline = "5m"
    }

    network {
      port "roulette" {
        to           = 4000
        host_network = "private"
      }
    }

    task "roulette" {
      driver = "docker"

      config {
        #image = "docker.cluster.entropy1729.com/aleo_roulette:latest"
        image = "docker.cluster.entropy1729.com/aleo_roulette:${IMAGE_VERSION}"

        force_pull = true

        labels { group = "roulette" }

        port_map {
          http = 4000
        }

        ports = ["roulette"]
      }

      template {
       # SECRET_KEY_BASE="{{with secret "secret/data/phoenix"}}{{.Data.data.secret_key_base}}{{end}}"
        data = <<EOH
            SECRET_KEY_BASE="{{with secret "secret/data/phoenix"}}{{.Data.data.secret_key_base}}{{end}}"
            PHX_HOST="roulette.cluster.entropy1729.com"
            EOH

        destination = "secrets/file.env"
        env         = true
      }


      service {
        name = "${TASK}"
        tags = [
          "urlprefix-roulette.cluster.entropy1729.com/",
          # Tells Fabio to redirect http to https
          "urlprefix-roulette.cluster.entropy1729.com:80/ redirect=301,https://roulette.cluster.entropy1729.com$path"
        ]

        address_mode = "host"
        port         = "roulette"

        check {
          type     = "tcp"
          port     = "roulette"
          interval = "10s"
          timeout  = "3s"
        }
      }
    }
  }
}
