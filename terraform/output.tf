output "vm_hostnames" {
  value       = { for instance, vm in google_compute_instance.vm : instance => vm.hostname }
  description = "A map of instance names to their respective hostnames"
}


output "vm_external_ip_addresses" {
  value       = { for instance, vm in google_compute_instance.vm : instance => vm.network_interface[0].access_config[0].nat_ip }
  description = "A map of instance FQDN to their respective external IP addresses"
}


output "vm_internal_ip_addresses" {
  value       = { for instance, vm in google_compute_instance.vm : instance => vm.network_interface[0].network_ip }
  description = "A map of instance FQDN to their respective internal IP addresses"
}
