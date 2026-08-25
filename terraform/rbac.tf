resource "kubernetes_service_account" "ecommerce_deployer" {
  metadata {
    name      = "ecommerce-deployer"
    namespace = kubernetes_namespace.ecommerce.metadata[0].name
  }
}

resource "kubernetes_role" "ecommerce_deployer_role" {
  metadata {
    name      = "ecommerce-deployer-role"
    namespace = kubernetes_namespace.ecommerce.metadata[0].name
  }

  rule {
    api_groups = [""]
    resources  = ["services", "configmaps", "secrets", "pods"]
    verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
  }

  rule {
    api_groups = ["apps"]
    resources  = ["deployments", "replicasets"]
    verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
  }
}

resource "kubernetes_role_binding" "ecommerce_deployer_binding" {
  metadata {
    name      = "ecommerce-deployer-binding"
    namespace = kubernetes_namespace.ecommerce.metadata[0].name
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role.ecommerce_deployer_role.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.ecommerce_deployer.metadata[0].name
    namespace = kubernetes_namespace.ecommerce.metadata[0].name
  }
}
