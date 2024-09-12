variable "branch_or_sha" {
  type = string
  default = "main"
}
job "imagecat-staging" {
  region = "global"
  datacenters = ["dc1"]
  node_pool = "staging"
  type = "service"
  group "web" {
    count = 2
    network {
      port "http" { to = 3000 }
    }
    service {
      port = "http"
      check {
        type = "http"
        port = "http"
        path = "/"
        interval = "10s"
        timeout = "1s"
      }
    }
    task "webserver" {
      driver = "docker"
      config {
        image = "ghcr.io/pulibrary/imagecat-rails:${ var.branch_or_sha }"
        ports = ["http"]
        force_pull = true
      }
      template {
        destination = "${NOMAD_SECRETS_DIR}/env.vars"
        env = true
        change_mode = "restart"
        data = <<EOF
        {{- with nomadVar "nomad/jobs/imagecat-staging" -}}
        SECRET_KEY_BASE = '{{ .SECRET_KEY_BASE }}'
        APP_DB = {{ .DB_NAME }}
        APP_DB_USERNAME = {{ .DB_USER }}
        APP_DB_PASSWORD = {{ .DB_PASSWORD }}
        APP_DB_HOST = {{ .POSTGRES_HOST }}
        APPLICATION_HOST = 'imagecat-staging.princeton.edu'
        APPLICATION_HOST_PROTOCOL = 'https'
        APPLICATION_PORT = '443'
        AWS_ACCESS_KEY_ID = {{ .AWS_ACCESS_KEY_ID }}
        AWS_SECRET_ACCESS_KEY = {{ .AWS_SECRET_ACCESS_KEY }}
        AWS_DEFAULT_REGION = 'us-east-1'
        {{- end -}}
        EOF
      }
    }
  }
}
