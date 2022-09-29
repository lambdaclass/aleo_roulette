job "roulette_app" {
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
      port "roulette_back" {
        to           = 3000
        host_network = "public"
      }
      port "roulette_front" {
        to           = 4000
        host_network = "public"
      }
    }

    task "roulette" {
      driver = "docker"

      config {
        #image = "docker.cluster.entropy1729.com/aleo_roulette:latest"
        image = "docker.cluster.entropy1729.com/aleo_roulette:${IMAGE_VERSION}"

        force_pull = true

        labels { group = "roulette" }

        ports = ["roulette_front", "roulette_back"]
      }

      env {
        REACT_APP_API_HOST = "https://api-roulette.cluster.entropy1729.com"
      }

      # resource config
      resources {
        cpu    = 1024
        memory = 8192
      }

      service {
        name = "${TASK}"
        tags = [
          "urlprefix-roulette.cluster.entropy1729.com/",
          # Tells Fabio to redirect http to https
          "urlprefix-roulette.cluster.entropy1729.com:80/ redirect=301,https://roulette.cluster.entropy1729.com$path"
        ]

        address_mode = "host"
        port         = "roulette_front"

        check {
          type     = "tcp"
          port     = "roulette_front"
          interval = "10s"
          timeout  = "3s"
        }
      }

      service {
        name = "${TASK}-back"
        tags = [
          "urlprefix-api-roulette.cluster.entropy1729.com/",
          # Tells Fabio to redirect http to https
          "urlprefix-api-roulette.cluster.entropy1729.com:80/ redirect=301,https://api-roulette.cluster.entropy1729.com$path"
        ]

        address_mode = "host"
        port         = "roulette_back"

        check {
          type     = "tcp"
          port     = "roulette_back"
          interval = "10s"
          timeout  = "3s"
        }
      }
    }
  }
}
