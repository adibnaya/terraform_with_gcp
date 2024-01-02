# Bucket to store website

resource "google_storage_bucket" "website" {
  name = var.website_name
  location = var.website_location
  website {
    main_page_suffix = "index.html"
  }
}

# Make new object public
resource "google_storage_object_access_control" "public_rule" {
  object = google_storage_bucket_object.static_site_source.name
  bucket = google_storage_bucket.website.name
  entity = "allUsers"
  role = "READER"

}

# Upload index.html to the bucket
resource "google_storage_bucket_object" "static_site_source" {
  name = "index.html"
  source = "../website/index.html"
  bucket = google_storage_bucket.website.name
}

# Reserve a static external IP address
resource "google_compute_global_address" "website_ip" {
  name = "website-lb-ip"
}

# Get the managed DNS zone
data "google_dns_managed_zone" "dns_zone" {
  name = var.dns_managed_zone
}

# Add the IP to the DNS
resource "google_dns_record_set" "website" {
  name = "website.${data.google_dns_managed_zone.dns_zone.dns_name}"
  type = "A"
  ttl = 300
  managed_zone = data.google_dns_managed_zone.dns_zone.name
  rrdatas = [google_compute_global_address.website_ip.address]
}

# Add the bucket as a CDN backend
resource "google_compute_backend_bucket" "website-backend" {
  name = "website-bucket"
  bucket_name = google_storage_bucket.website.name
  description = "Contains files needed for the website"
  enable_cdn = true
}

# GCP URL map
resource "google_compute_url_map" "website" {
  name = "website-url-map"
  default_service = google_compute_backend_bucket.website-backend.self_link
  host_rule {
    hosts = ["*"]
    path_matcher = "allpathes"
  }
  path_matcher {
    name = "allpathes"
    default_service = google_compute_backend_bucket.website-backend.self_link
  }
}

# GCP HTTP Proxy
resource "google_compute_target_http_proxy" "website" {
  name = "website-target-proxy"
  url_map = google_compute_url_map.website.self_link
}

# Create HTTPS certificate
resource "google_compute_managed_ssl_certificate" "website" {
  provider = google-beta
  name = "website-cert"
  managed {
    domains = [google_dns_record_set.website.name]
  }
}

# GCP forwarding rule
resource "google_compute_global_forwarding_rule" "default" {
  name = "website-forwarding-rule"
  load_balancing_scheme = "EXTERNAL"
  ip_address = google_compute_global_address.website_ip.address
  ip_protocol = "TCP"
  # port_range = "80"
  port_range = "443"
  target = google_compute_target_http_proxy.website.self_link
}