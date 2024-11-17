resource "google_compute_instance" "vm" {
  for_each     = var.instances # Loop through the instances map to create multiple VM instances
  project      = var.project_id
  name         = each.key                                    # Set the instance name from the map key
  description  = each.value.description                      # Set description from map value
  machine_type = each.value.machine_type                     # Set machine_type from map value
  zone         = each.value.zone                             # Set the zone from map value
  hostname     = "${each.key}-${each.value.zone}.asx.com.au" # Dynamically generate the hostname
  # Dynamic block to conditionally configure the service account, if provided
  dynamic "service_account" {
    # `for_each` iterates over a list to conditionally create the `service_account` block.
    # If `var.service_account` is not an empty string, the expression evaluates to a list `[1]`,
    # If `var.service_account` is an empty string, the expression evaluates to an empty list `[]`, and the block is skipped.
    # This allows the service account block to be conditionally included based on the `service_account` variable.
    for_each = var.service_account != "" ? [1] : []
    # The `content` block defines the actual configuration for the `service_account` when it's created.
    # Provides the settings for the service_account, specifically the email and scopes.
    content {
       # email value comes from the var.service_account variable
      email  = var.service_account
      # scope value comes from the var.scopes variable
      scopes = var.scopes
    }
  }
  # Boot disk block (required) to eliminate eroror
  boot_disk {
  }
  # Network interface block (required) to eliminate eroror
  network_interface {
  }
}
