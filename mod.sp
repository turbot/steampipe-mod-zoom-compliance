// Benchmarks and controls for specific services should override the "service" tag
locals {
  zoom_compliance_common_tags = {
    category = "Compliance"
    plugin   = "zoom"
    service  = "Zoom"
  }
}

mod "zoom_compliance" {
  title         = "Zoom Compliance"
  description   = "Run individual configuration, compliance and security controls or full compliance benchmarks for CIS for Zoom using Steampipe."
  color         = "#2D8CFF"
  documentation = file("./docs/index.md")
  icon          = "/images/mods/turbot/zoom-compliance.svg"
  categories    = ["cis", "compliance", "saas", "security"]

  opengraph {
    title       = "Steampipe Mod for Zoom"
    description = "Run individual configuration, compliance and security controls or full compliance benchmarks for CIS for Zoom using Steampipe."
    image       = "/images/mods/turbot/zoom-compliance-social-graphic.png"
  }
}
