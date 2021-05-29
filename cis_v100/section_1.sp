
benchmark "cis_v100_1" {
  title         = "1 Account Settings"
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1"
  })
  children = [
    benchmark.cis_v100_1_1,
    benchmark.cis_v100_1_2,
    benchmark.cis_v100_1_3,
  ]
}

benchmark "cis_v100_1_1" {
  title         = "1.1 Meeting"
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1"
  })
  children = [
    benchmark.cis_v100_1_1_1,
    benchmark.cis_v100_1_1_2,
    benchmark.cis_v100_1_1_3,
    benchmark.cis_v100_1_1_4,
    benchmark.cis_v100_1_1_5,
    benchmark.cis_v100_1_1_6,
    benchmark.cis_v100_1_1_7,
  ]
}
