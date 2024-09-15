locals {
  zones = {
    shared   = "share.kurstf.com."
    krakow   = "krakow.kurstf.com."
    warszawa = "warszawa.kurstf.com."
    gdansk   = "gdansk.kurstf.com."
  }
  zone_keys = keys(local.zones)
}

resource "google_dns_managed_zone" "private" {
  for_each    = local.zones
  name        = "private-${each.key}-${local.prefix}"
  dns_name    = each.value
  description = "${each.key} private DNS zone linked to VPC ${google_compute_network.shared.name}"

  visibility = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.shared.id
    }
  }

  forwarding_config {
    target_name_servers {
      ipv4_address = "172.16.10.10"
    }
  }
}