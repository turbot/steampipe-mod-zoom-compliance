locals {
  cis_v100_1_1_common_tags = merge(local.cis_v100_1_common_tags, {
    cis_section_id = "1.1"
  })
}

benchmark "cis_v100_1_1" {
  title         = "1.1 Meeting"
  children = [
    benchmark.cis_v100_1_1_1,
    benchmark.cis_v100_1_1_2,
    benchmark.cis_v100_1_1_3,
    benchmark.cis_v100_1_1_4,
    benchmark.cis_v100_1_1_5,
    benchmark.cis_v100_1_1_6,
    benchmark.cis_v100_1_1_7,
  ]

  tags = merge(local.cis_v100_1_1_common_tags, {
    type = "Benchmark"
  })
}
