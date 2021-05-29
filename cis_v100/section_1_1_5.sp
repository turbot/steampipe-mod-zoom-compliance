
benchmark "cis_v100_1_1_5" {
  title         = "1.1.5 Calendar and Contacts"
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.5"
  })
  children = [
    control.cis_v100_1_1_5_1,
    control.cis_v100_1_1_5_2,
    control.cis_v100_1_1_5_3,
    control.cis_v100_1_1_5_4,
  ]
}

control "cis_v100_1_1_5_1" {
  title         = "1.1.5.1 Ensure calendar and contacts integration is set to disabled (Manual)"
  description   = "Allow users to integrate calendar and contacts services (Google, Exchange, Office 365) with Zoom. Enabling this option shall invite privacy issues, hence keep this disabled."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.5.1"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = query.no_api_available.sql
}

control "cis_v100_1_1_5_2" {
  title         = "1.1.5.2 Ensure ask users to integrate Office 365 calendar when they sign in is set to disabled (Manual)"
  description   = "Upon login, users will be asked for calendar access. Enabling this option invites privacy issues, hence it is best to keep it disabled."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.5.2"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = query.no_api_available.sql
}

control "cis_v100_1_1_5_3" {
  title         = "1.1.5.3 Ensure consent to Office 365 calendar integration permissions on behalf of entire account is set to disabled (Manual)"
  description   = "When turned off, the Office 365 administrator will need to consent to calendar integrations on behalf of the account. As an administrator, please choose the same settings configured in Office 365. View the settings on Office 365."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.5.3"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = query.no_api_available.sql
}

control "cis_v100_1_1_5_4" {
  title         = "1.1.5.4 Ensure enforce OAuth 2.0 for Office 365 calendar integration is set to enabled (Manual)"
  description   = "When turned on, calendar services will be authenticated with protocol OAuth 2.0."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.5.4"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = query.no_api_available.sql
}
