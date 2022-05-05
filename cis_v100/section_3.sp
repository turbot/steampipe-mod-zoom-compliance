
locals {
  cis_v100_3_common_tags = merge(local.cis_v100_common_tags, {
    cis_section_id = "3"
  })
}

locals {
  cis_v100_3_1_common_tags = merge(local.cis_v100_3_common_tags, {
    cis_section_id = "3.1"
  })
}


benchmark "cis_v100_3" {
  title         = "3 Advanced"
  children = [
    benchmark.cis_v100_3_1,
    control.cis_v100_3_2,
  ]

  tags = merge(local.cis_v100_3_common_tags, {
    service = "Zoom/Security"
    type = "Benchmark"
  })
}

benchmark "cis_v100_3_1" {
  title         = "3.1 Security"
  children = [
    benchmark.cis_v100_3_1_1,
  ]

  tags = merge(local.cis_v100_3_1_common_tags, {
    service = "Zoom/Security"
    type = "Benchmark"
  })
}

benchmark "cis_v100_3_1_1" {
  title         = "3.1.1 Authentication"
  children = [
    benchmark.cis_v100_3_1_1_1,
    benchmark.cis_v100_3_1_1_2,
    benchmark.cis_v100_3_1_1_3,
  ]

  tags = merge(local.cis_v100_3_common_tags, {
    service = "Zoom/Security"
    type = "Benchmark"
    cis_section_id = "3.1.1"
  })
}

benchmark "cis_v100_3_1_1_1" {
  title         = "3.1.1.1 Enhanced Password Requirement"
  children = [
    control.cis_v100_3_1_1_1_1,
    control.cis_v100_3_1_1_1_2,
    control.cis_v100_3_1_1_1_3,
    control.cis_v100_3_1_1_1_4,
  ]

  tags = merge(local.cis_v100_3_common_tags, {
    service = "Zoom/Security"
    type = "Benchmark"
    cis_section_id = "3.1.1.1"
  })
}

control "cis_v100_3_1_1_1_1" {
  title         = "3.1.1.1.1 Ensure minimum password length is set to 9 characters or greater (Manual)"
  description   = "Have a minimum password length of 9 characters or greater."
  tags = merge(local.cis_v100_3_common_tags, {
    cis_item_id = "3.1.1.1.1"
    cis_level = 2
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (security -> 'password_requirement' -> 'minimum_password_length')::int >= 9 then 'ok'
        else 'alarm'
      end as status,
      'Minimum password length set to ' || (security -> 'password_requirement' ->> 'minimum_password_length') || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_3_1_1_1_2" {
  title         = "3.1.1.1.2 Ensure password have at least 1 special character is set to enabled (Manual)"
  description   = "Have at least 1 special character (!, @, #...)."
  tags = merge(local.cis_v100_3_common_tags, {
    cis_item_id = "3.1.1.1.2"
    cis_level = 2
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (security -> 'password_requirement' -> 'have_special_character')::bool then 'ok'
        else 'alarm'
      end as status,
      'Have at least 1 special character setting is ' || case when (security -> 'password_requirement' -> 'have_special_character')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_3_1_1_1_3" {
  title         = "3.1.1.1.3 Ensure password cannot contain consecutive characters is set to enabled (Manual)"
  description   = "Cannot contain consecutive characters (e.g. \"11111\", \"12345\", \"abcde\", or \"qwert\") and specify the length of consecutive characters to 4 or above."
  tags = merge(local.cis_v100_3_common_tags, {
    cis_item_id = "3.1.1.1.1"
    cis_level = 2
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (security -> 'password_requirement' -> 'consecutive_characters_length')::int >= 9 then 'ok'
        else 'alarm'
      end as status,
      'Consecutive characters length set to ' || (security -> 'password_requirement' ->> 'consecutive_characters_length') || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_3_1_1_1_4" {
  title         = "3.1.1.1.4 Ensure use enhanced weak password detection is set to enabled (Manual)"
  description   = "Use enhanced weak password detection."
  tags = merge(local.cis_v100_3_common_tags, {
    cis_item_id = "3.1.1.1.4"
    cis_level = 2
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (security -> 'password_requirement' -> 'weak_enhance_detection')::bool then 'ok'
        else 'alarm'
      end as status,
      'Weak password detection is ' || case when (security -> 'password_requirement' -> 'weak_enhance_detection')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

benchmark "cis_v100_3_1_1_2" {
  title         = "3.1.1.2 Password Policy"
  children = [
    control.cis_v100_3_1_1_2_1,
    control.cis_v100_3_1_1_2_2,
    control.cis_v100_3_1_1_2_3,
    control.cis_v100_3_1_1_2_4,
  ]

  tags = merge(local.cis_v100_3_common_tags, {
    service = "Zoom/Security"
    type = "Benchmark"
    cis_section_id = "3.1.1.2"
  })
}

control "cis_v100_3_1_1_2_1" {
  title         = "3.1.1.2.1 Ensure new users need to change their passwords upon first sign-in is set to enabled (Manual)"
  description   = "New users need to change their passwords upon first sign-in."
  tags = merge(local.cis_v100_3_common_tags, {
    cis_item_id  = "3.1.1.2.1"
    cis_type     = "manual"
    cis_level    = "2"
  })
  sql = query.no_api_available.sql
}

control "cis_v100_3_1_1_2_2" {
  title         = "3.1.1.2.2 Ensure password expires automatically and needs to be changed after 365 days (Manual)"
  description   = "Password expires automatically and needs to be changed after the specified number of days."
  tags = merge(local.cis_v100_3_common_tags, {
    cis_item_id  = "3.1.1.2.2"
    cis_type     = "manual"
    cis_level    = "2"
  })
  sql = query.no_api_available.sql
}

control "cis_v100_3_1_1_2_3" {
  title         = "3.1.1.2.3 Ensure users cannot reuse any password used in the last 5 times or more (Manual)"
  description   = "Users cannot reuse any password used in the previous number of times."
  tags = merge(local.cis_v100_3_common_tags, {
    cis_item_id  = "3.1.1.2.3"
    cis_type     = "manual"
    cis_level    = "2"
  })
  sql = query.no_api_available.sql
}

control "cis_v100_3_1_1_2_4" {
  title         = "3.1.1.2.4 Enable users can change their password 1 time every 24 hours (Manual)"
  description   = "Users can change their password 1 time every 24 hours."
  tags = merge(local.cis_v100_3_common_tags, {
    cis_item_id  = "3.1.1.2.4"
    cis_type     = "manual"
    cis_level    = "2"
  })
  sql = query.no_api_available.sql
}

benchmark "cis_v100_3_1_1_3" {
  title         = "3.1.1.3 Security"
  children = [
    control.cis_v100_3_1_1_3_1,
    control.cis_v100_3_1_1_3_2,
    control.cis_v100_3_1_1_3_3,
  ]

  tags = merge(local.cis_v100_3_common_tags, {
    service = "Zoom/Security"
    type = "Benchmark"
    cis_section_id = "3.1.1.3"
  })
}

control "cis_v100_3_1_1_3_1" {
  title         = "3.1.1.3.1 Ensure only account admin can change licensed users' personal meeting ID and personal link name (Manual)"
  description   = "Only account admin can change licensed users' Personal Meeting ID and Personal Link Name."
  tags = merge(local.cis_v100_3_common_tags, {
    cis_item_id  = "3.1.1.3.1"
    cis_type     = "manual"
    cis_level    = "2"
  })
  sql = query.no_api_available.sql
}

control "cis_v100_3_1_1_3_2" {
  title         = "3.1.1.3.2 Ensure allow importing of photos from the photo library on the user's device is set to disabled (Manual)"
  description   = "Allow importing of photos from the photo library on the user's device."
  tags = merge(local.cis_v100_3_common_tags, {
    cis_item_id = "3.1.1.3.2"
    cis_level = 2
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (security -> 'import_photos_from_devices')::bool then 'alarm'
        else 'ok'
      end as status,
      'Import photos from devices is ' || case when (security -> 'import_photos_from_devices')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_3_1_1_3_3" {
  title         = "3.1.1.3.3 Ensure hide billing information from administrators is set to enabled (Manual)"
  description   = "Hide billing information from administrators."
  tags = merge(local.cis_v100_3_common_tags, {
    cis_item_id = "3.1.1.3.3"
    cis_level = 2
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (security -> 'hide_billing_info')::bool then 'ok'
        else 'alarm'
      end as status,
      'Hide billing information from administrators is ' || case when (security -> 'hide_billing_info')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_3_2" {
  title         = "3.2 Ensure integration is set to appropriate organizational needs (Manual)"
  description   = "Integration, this page has option to enable/disable to various applications that can be integrated with zoom."
  tags = merge(local.cis_v100_3_common_tags, {
    cis_item_id = "3.2"
    cis_level = 2
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case when (i.value)::bool then 'info' else 'ok' end as status,
      i.key || ' integration is ' || case when (i.value)::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings,
      jsonb_each(integration) as i
  EOQ
}
