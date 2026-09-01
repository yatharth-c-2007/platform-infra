
resource "helm_release" "kube_prometheus_stack" {
	name = "kube-prometheus-stack"
	repository = "https://prometheus-community.github.io/helm-charts"
	chart = "kube-prometheus-stack"
namespace = "monitoring"
version = "87.16.1"
	create_namespace = true
}
	
