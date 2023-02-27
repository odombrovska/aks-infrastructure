terraform {
    required_providers {
        kubectl = {
        source  = "gavinbunney/kubectl"
        }
    }
}

resource "helm_release" "cert-manager" {
    name       = "cert-manager"
    namespace  = "cert-manager"
    repository = "https://charts.jetstack.io"
    chart      = "cert-manager"
        
        set {
            name  = "installCRDs"
            value = "true"
        }

        set {
            name  = "resources.limits.memory"
            value = "100Mi"
        }

        set {
            name  = "resources.limits.cpu"
            value = "300m"
        }

        set {
            name  = "resources.requests.memory"
            value = "100Mi"
        }

        set {
            name  = "resources.requests.cpu"
            value = "300m"
        }
}

data "kubectl_file_documents" "cluster_issuer" {
    content  = file("${path.module}/cluster-issuer.yaml")
}

data "kubectl_file_documents" "certificate" {
    content  = file("${path.module}/certificate.yaml")
}

resource "kubectl_manifest" "cluster_issuer_deployment" {
    depends_on = [
        helm_release.cert-manager
    ]
    
    yaml_body = data.kubectl_file_documents.cluster_issuer.content
}

resource "kubectl_manifest" "certificate_deployment" {
    depends_on = [
        kubectl_manifest.cluster_issuer_deployment
    ]

    yaml_body = data.kubectl_file_documents.certificate.content
}