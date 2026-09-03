resource "helm_release" "argocd" {
	name = "argocd"
	repository = "https://argoproj.github.io/argo-helm"
	chart = "argo-cd"
	namespace = "argocd"
	version = "10.7.0"
	set {
		name = "dex.enabled"
		value = "false"
	}
	set { 
		name = "notification.enabled"
		value = "false"
	}
	set {
		name = "applicationSet.enabled"
		value = "false"
	}
	set {
		name = "controller.resources.requests.memory"
		value = "256Mi"
	}
}
