# Vagrantfile
#
# Brings up the 3-VM base for our kubeadm cluster:
#   - k8s-control-plane : 192.168.56.10
#   - k8s-worker-1       : 192.168.56.11
#   - k8s-worker-2       : 192.168.56.12
#
# This phase ONLY stands up bare VMs on a private network so they can
# reach each other. Provisioning (containerd, kubeadm install, cluster
# join) is deliberately left to Ansible in the next phase, not baked
# in here — keeps the "Day -1 infra" and "Day 0 provisioning" concerns
# separate, which is how this would realistically be split in a real
# platform-infra repo.

VMS = [
  { name: "k8s-control-plane", ip: "192.168.56.10", cpus: 2, memory: 2048 },
  { name: "k8s-worker-1",      ip: "192.168.56.11", cpus: 2, memory: 1536 },
  { name: "k8s-worker-2",      ip: "192.168.56.12", cpus: 2, memory: 1536 },
]

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"

  VMS.each do |vm_config|
    config.vm.define vm_config[:name] do |node|
      node.vm.hostname = vm_config[:name]
      node.vm.network "private_network", ip: vm_config[:ip]

      node.vm.provider "virtualbox" do |vb|
        vb.name = vm_config[:name]
        vb.cpus = vm_config[:cpus]
        vb.memory = vm_config[:memory]
        # Linked clones share the base box image on disk instead of
        # copying it 3 times — saves disk space, faster `vagrant up`.
        vb.linked_clone = true
      end

      # Nothing beyond basic hostname/network setup here on purpose.
      # Ansible (Phase 3) handles: disabling swap, installing containerd,
      # installing kubeadm/kubelet/kubectl, and the actual cluster join.
    end
  end
end

