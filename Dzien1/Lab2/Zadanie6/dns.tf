locals {
  zones = {
    shared = "share.kurstf.com."
  }
  zone_keys = keys(local.zones)
}

resource "google_dns_managed_zone" "private" {
  name        = "private-${local.zone_keys[0]}-${local.prefix}"
  dns_name    = local.zones.shared
  description = "${upper(local.zone_keys[0])} private DNS zone"

  visibility = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.shared.id
    }
  }
}