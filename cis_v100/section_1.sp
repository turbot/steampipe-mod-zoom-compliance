locals {
  cis_v100_1_common_tags = merge(local.cis_v100_common_tags, {
    cis_section_id = "1"
  })
}

benchmark "cis_v100_1" {
  title = "1 Account Settings"
  children = [
    benchmark.cis_v100_1_1,
    benchmark.cis_v100_1_2,
    benchmark.cis_v100_1_3,
  ]

  tags = merge(local.cis_v100_1_common_tags, {
    type = "Benchmark"
  })
}
