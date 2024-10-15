mod "zoom_compliance" {
  # Hub metadata
  title         = "Zoom Compliance"
  description   = "Run individual configuration, compliance and security controls or full compliance benchmarks for CIS for Zoom using Powerpipe and Steampipe."
  color         = "#2D8CFF"
  documentation = file("./docs/index.md")
  icon          = "/images/mods/turbot/zoom-compliance.svg"
  categories    = ["cis", "compliance", "saas", "security"]

  opengraph {
    title       = "Powerpipe Mod for Zoom"
    description = "Run individual configuration, compliance and security controls or full compliance benchmarks for CIS for Zoom using Powerpipe and Steampipe."
    image       = "/images/mods/turbot/zoom-compliance-social-graphic.png"
  }
}
