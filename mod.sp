mod "zoom" {
  title         = "Zoom Compliance"
  description   = "Steampipe Mod for Zoom"
  description   = "Run individual configuration, compliance and security controls or full compliance benchmarks for CIS for Zoom using Steampipe."
  color         = "#2D8CFF"
  documentation = file("./zoom_cis_docs.md")
  icon          = "/images/plugins/turbot/zoom.svg"
  categories    = ["cis", "compliance", "saas", "security"]

  opengraph {
    title       = "Steampipe Mod for Zoom"
    description = "Run individual configuration, compliance and security controls or full compliance benchmarks for CIS for Zoom using Steampipe."
    image       = "/images/mods/turbot/zoom-compliance-social-graphic.png"
  }
}
