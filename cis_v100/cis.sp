locals {
  cis_v100_common_tags = merge(local.zoom_compliance_common_tags, {
    cis         = "true"
    cis_version = "v1.0.0"
  })
}

benchmark "cis_v100" {
  title       = "CIS v1.0.0"
  description = "The CIS Zoom Benchmark provides prescriptive guidance for configuring security options for Zoom."
  #documentation = file("./cis_v1_3_0/docs/cis-overview.md")
  children = [
    benchmark.cis_v100_1,
    benchmark.cis_v100_2,
    benchmark.cis_v100_3
  ]

  tags = merge(local.cis_v100_common_tags, {
    type = "Benchmark"
  })
}
