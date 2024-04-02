/*
# Create Kubernetes resource with the manifest
resource "kubernetes_manifest" "kubernetes_apply_mongo_namespace" {
  manifest = yamldecode(file("../k8s_manifests/mongo/namespace.yaml"))
}

resource "kubernetes_manifest" "kubernetes_apply_mongo_secrets" {
  manifest = yamldecode(file("../k8s_manifests/mongo/secrets.yaml"))
  depends_on = [ kubernetes_manifest.kubernetes_apply_mongo_namespace ]
}

resource "kubernetes_manifest" "kubernetes_apply_mongo_deploy" {
  manifest = yamldecode(file("../k8s_manifests/mongo/deploy.yaml"))
  depends_on = [ kubernetes_manifest.kubernetes_apply_mongo_secrets ]
}

resource "kubernetes_manifest" "kubernetes_apply_mongo_service" {
  manifest = yamldecode(file("../k8s_manifests/mongo/service.yaml"))
  depends_on = [ kubernetes_manifest.kubernetes_apply_mongo_deploy ]
}

resource "kubernetes_manifest" "kubernetes_apply_backend_deploy" {
  manifest = yamldecode(file("../k8s_manifests/backend-deployment.yaml"))
  depends_on = [ kubernetes_manifest.kubernetes_apply_mongo_service ]
}

resource "kubernetes_manifest" "kubernetes_apply_backend_service" {
  manifest = yamldecode(file("../k8s_manifests/backend-service.yaml"))
  depends_on = [ kubernetes_manifest.kubernetes_apply_backend_deploy ]
}

resource "kubernetes_manifest" "kubernetes_apply_frontend_deploy" {
  manifest = yamldecode(file("../k8s_manifests/frontend-deployment.yaml"))
  depends_on = [ kubernetes_manifest.kubernetes_apply_backend_service ]
}

resource "kubernetes_manifest" "kubernetes_apply_frontend_service" {
  manifest = yamldecode(file("../k8s_manifests/frontend-service.yaml"))
  depends_on = [ kubernetes_manifest.kubernetes_apply_frontend_deploy ]
}

resource "kubernetes_manifest" "kubernetes_apply_lb_service" {
  manifest = yamldecode(file("../k8s_manifests/full_stack_lb.yaml"))
  depends_on = [ kubernetes_manifest.kubernetes_apply_frontend_deploy ]
}
*/