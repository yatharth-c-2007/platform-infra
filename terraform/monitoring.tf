
resource "helm_release" "kube_prometheus_stack" {
	name = "kube-prometheus-stack"
	repository = "https://prometheus-community.github.io/helm-charts"
	chart = "kube-prometheus-stack"
	namespace = "monitoring"
	version = "87.16.1"
	create_namespace = true
}
	
resource "helm_release" "loki_stack" {
	name = "loki-stack"
	repository = "https://grafana.github.io/helm-charts"
	chart = "loki-stack"
	version = "2.10.3"
	namespace = "monitoring"
}
