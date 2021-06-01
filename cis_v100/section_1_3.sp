
benchmark "cis_v100_1_3" {
  title         = "1.3 Telephone"
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.3"
  })
  children = [
    control.cis_v100_1_3_1,
    control.cis_v100_1_3_2,
    control.cis_v100_1_3_3,
  ]
}

control "cis_v100_1_3_1" {
  title         = "1.3.1 Ensure toll call is set to enabled (Manual)"
  description   = "Include the selected numbers in the Zoom client and the email invitation via the international numbers link. Participants can dial into meeting with the numbers. Further add/modify/remove the toll numbers as per organization requirements."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id  = "1.3.1"
    cis_type     = "manual"
    cis_level    = 2
  })
  sql = query.no_api_available.sql
}

control "cis_v100_1_3_2" {
  title         = "1.3.2 Ensure mask phone number in the participant list is set to enabled (Manual)"
  description   = "Phone numbers of users dialing into a meeting will be masked in the participant list. For example: 888****666"
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id  = "1.3.2"
    cis_type     = "manual"
    cis_level    = 2
  })
  sql = query.no_api_available.sql
}

control "cis_v100_1_3_3" {
  title         = "1.3.3 Ensure global dial-in countries/regions is set to enabled (Manual)"
  description   = "Countries/regions that frequently have participants who need to dial into meetings. The dial-in phone numbers of these locations appear in the email invitation, and can be used by participants dialing in from those locations. Further select Dial-in number(s) that are as per your local country or region laws, if any."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id  = "1.3.3"
    cis_type     = "manual"
    cis_level    = 2
  })
  sql = <<-EOQ
    select
      -- Required Columns
      a.account_id as resource,
      'info' as status,
      cc || ' is enabled.' as reason
    from
      zoom_account_settings as a,
      jsonb_array_elements_text(telephony -> 'telephony_regions' -> 'allowed_values') as cc
  EOQ
}
