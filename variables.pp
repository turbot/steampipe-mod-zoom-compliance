// Benchmarks and controls for specific services should override the "service" tag
locals {
  zoom_compliance_common_tags = {
    category = "Compliance"
    plugin   = "zoom"
    service  = "Zoom"
  }
}
