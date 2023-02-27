terraform {
    required_providers {
        kubectl = {
        source  = "gavinbunney/kubectl"
        }
    }
}

resource "helm_release" "nginx_ingress" {
    name       = "nginx-ingress"
    namespace  = "nginx-ingress"
    repository = "https://helm.nginx.com/stable"
    chart      = "nginx-ingress"
        
        set {
            name  = "controller.replicaCount"
            value = "2"
        }

        set {
            name  = "controller.service.loadBalancerIP"
            value = var.public_ip_address
        }

        set {
            name  = "resources.limits.memory"
            value = "300Mi"
        }

        set {
            name  = "resources.limits.cpu"
            value = "500m"
        }

        set {
            name  = "resources.requests.memory"
            value = "300Mi"
        }

        set {
            name  = "resources.requests.cpu"
            value = "500m"
        }
}

data "kubectl_file_documents" "ingress_rules" {
    content = file("${path.module}/ingress.yaml")
}

resource "kubectl_manifest" "ingress_rules_deployment" {
    depends_on = [
        helm_release.nginx_ingress
    ]

    yaml_body = data.kubectl_file_documents.ingress_rules.content
}
