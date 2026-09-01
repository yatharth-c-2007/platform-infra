provider "helm" {
	kubernetes {
		config_path = "${path.module}/kubeconfig"
	}
}
resource "helm_release" "istio_base" {
	name = "istio-base"
	repository = "https://istio-release.storage.googleapis.com/charts"
	chart = "base"
	namespace = "istio-system"
	version = "1.30.0"
	create_namespace = true
}
	
resource "helm_release" "istiod" {
	name = "istiod"
	repository = "https://istio-release.storage.googleapis.com/charts"
	chart = "istiod"
	namespace = "istio-system"
	version = "1.30.0"
	depends_on = [helm_release.istio_base]
	set {
		name = "pilot.resources.requests.memory"
		value = "512Mi"
	}
}

resource "helm_release" "istio_gateway" {
	name = "istio-gateway"
	repository = "https://istio-release.storage.googleapis.com/charts"
	chart = "gateway"
	namespace = "istio-system"
	version = "1.30.0"
	depends_on = [helm_release.istiod]
	timeout = 900
	set {
		name = "service.type"
		value = "NodePort"
	}
}
