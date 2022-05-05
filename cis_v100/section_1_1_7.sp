
locals {
  cis_v100_1_1_7_common_tags = merge(local.cis_v100_common_tags, {
    cis_section_id = "1.1.7"
  })
}

benchmark "cis_v100_1_1_7" {
  title         = "1.1.7 Admin Options"
  # tags = merge(local.cis_v100_common_tags, {
  #   cis_item_id = "1.1.7"
  # })
  children = [
    control.cis_v100_1_1_7_1,
    control.cis_v100_1_1_7_2,
    control.cis_v100_1_1_7_3,
    control.cis_v100_1_1_7_4,
  ]

  tags = merge(local.cis_v100_1_1_6_common_tags, {
    service = "Zoom/Meeting"
    type = "Benchmark"
  })
}

control "cis_v100_1_1_7_1" {
  title         = "1.1.7.1 Ensure blur snapshot on iOS task switcher is set to enabled (Manual)"
  description   = "Enable this option to hide potentially sensitive information from the snapshot of the Zoom main window. This snapshot display as the preview screen in the iOS tasks switcher when multiple apps are open."
  tags = merge(local.cis_v100_1_1_7_common_tags, {
    cis_item_id = "1.1.7.1"
    cis_type     = "manual"
    cis_level    = 2
  })
  sql = query.no_api_available.sql
}

control "cis_v100_1_1_7_2" {
  title         = "1.1.7.2 Ensure display meetings scheduled for others is set to enabled (Manual)"
  description   = "Display meetings scheduled for others. If disabled, users will only see their meetings even if they have schedule-for privilege for others."
  tags = merge(local.cis_v100_1_1_7_common_tags, {
    cis_item_id = "1.1.7.2"
    cis_type     = "manual"
    cis_level    = 2
  })
  sql = query.no_api_available.sql
}

control "cis_v100_1_1_7_3" {
  title         = "1.1.7.3 Ensure use content delivery network (CDN) is set to \"Default\" (Manual)"
  description   = "Allow connections to different CDNs for a better web browsing experience. All users under your organization will use the selected CDN to access static resources. By default, all users use Amazon CloudFront except users in China. Users in China use Wangsu (China) instead."
  tags = merge(local.cis_v100_1_1_7_common_tags, {
    cis_item_id = "1.1.7.3"
    cis_type     = "manual"
    cis_level    = 2
  })
  sql = query.no_api_available.sql
}

control "cis_v100_1_1_7_4" {
  title         = "1.1.7.4 Ensure allow users to contact Zoom's support via chat is set to enabled (Manual)"
  description   = "Show Zoom Help badge on the bottom right of the page."
  tags = merge(local.cis_v100_1_1_7_common_tags, {
    cis_item_id = "1.1.7.4"
    cis_type     = "manual"
    cis_level    = 2
  })
  sql = query.no_api_available.sql
}
