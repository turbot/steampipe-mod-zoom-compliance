
benchmark "cis_v100_1_1_1" {
  title         = "1.1.1 Security"
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.1"
  })
  children = [
    benchmark.cis_v100_1_1_1_1,
    control.cis_v100_1_1_1_2,
    control.cis_v100_1_1_1_3,
    control.cis_v100_1_1_1_4,
    control.cis_v100_1_1_1_5,
    control.cis_v100_1_1_1_6,
    control.cis_v100_1_1_1_7,
    control.cis_v100_1_1_1_8,
    control.cis_v100_1_1_1_9,
    control.cis_v100_1_1_1_10,
    control.cis_v100_1_1_1_11,
  ]
}

benchmark "cis_v100_1_1_1_1" {
  title         = "1.1.1.1 Passcode Requirement"
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.1.1"
  })
  children = [
    control.cis_v100_1_1_1_1_1,
    control.cis_v100_1_1_1_1_2,
    control.cis_v100_1_1_1_1_3,
    control.cis_v100_1_1_1_1_4,
    control.cis_v100_1_1_1_1_5,
    control.cis_v100_1_1_1_1_6,
    control.cis_v100_1_1_1_1_7,
    control.cis_v100_1_1_1_1_8,
  ]
}

control "cis_v100_1_1_1_1_1" {
  title         = "1.1.1.1.1 Ensure minimum passcode length is set to at least 6 characters (Manual)"
  description   = "For security purposes, Zoom has a few requirements that your passcode must meet. Minimum passcode length must be at least 6 characters."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.1.1.1"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (meeting_security -> 'meeting_password_requirement' -> 'length')::int >= 6 then 'ok'
        else 'alarm'
      end as status,
      'Minimum passcode length set to ' || (meeting_security -> 'meeting_password_requirement' ->> 'length') || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_1_1_2" {
  title         = "1.1.1.1.2 Ensure passcode is set to have at least 1 letter (Manual)"
  description   = "For security purposes, Zoom has a few requirements that your passcode must meet. As per passcode requirements, have at least 1 letter (a, b, c...). This shall make the passcode strong."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.1.1.2"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (meeting_security -> 'meeting_password_requirement' -> 'have_letter')::bool then 'ok'
        else 'alarm'
      end as status,
      'Have at least 1 letter setting is ' || case when (meeting_security -> 'meeting_password_requirement' -> 'have_letter')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_1_1_3" {
  title         = "1.1.1.1.3 Ensure passcode is set to have at least 1 number (Manual)"
  description   = "For security purposes, Zoom has a few requirements that your passcode must meet. As per passcode requirements, Have at least 1 number (1, 2, 3...). This shall make the passcode strong."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.1.1.3"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (meeting_security -> 'meeting_password_requirement' -> 'have_number')::bool then 'ok'
        else 'alarm'
      end as status,
      'Have at least 1 number setting is ' || case when (meeting_security -> 'meeting_password_requirement' -> 'have_number')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_1_1_4" {
  title         = "1.1.1.1.4 Ensure passcode is set to have at least 1 special character (Manual)"
  description   = "For security purposes, Zoom has a few requirements that your passcode must meet. As per passcode requirements, Have at least 1 special character (!, @, #...). This shall make the passcode strong."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.1.1.4"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (meeting_security -> 'meeting_password_requirement' -> 'have_special_character')::bool then 'ok'
        else 'alarm'
      end as status,
      'Have special character setting is ' || case when (meeting_security -> 'meeting_password_requirement' -> 'have_special_character')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_1_1_5" {
  title         = "1.1.1.1.5 Ensure passcode include both uppercase and lowercase characters is set to enabled (Manual)"
  description   = "For security purposes, Zoom has a few requirements that your passcode must meet. As per passcode requirements, Include both uppercase and lowercase characters. This shall make the passcode strong."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.1.1.5"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (meeting_security -> 'meeting_password_requirement' -> 'have_upper_and_lower_characters')::bool then 'ok'
        else 'alarm'
      end as status,
      'Have uppercase and lowercase characters setting is ' || case when (meeting_security -> 'meeting_password_requirement' -> 'have_upper_and_lower_characters')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_1_1_6" {
  title         = "1.1.1.1.6 Ensure passcode cannot contain consecutive characters is set to enabled (Manual)"
  description   = "For security purposes, Zoom has a few requirements that your passcode must meet. Cannot contain consecutive characters (e.g. \"11111\", \"12345\", \"abcde\", or \"qwert\")."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.1.1.6"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (meeting_security -> 'meeting_password_requirement' -> 'consecutive_characters_length')::int > 0 then 'ok'
        else 'alarm'
      end as status,
      'Consecutive characters length set to ' || (security -> 'password_requirement' ->> 'consecutive_characters_length') || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_1_1_7" {
  title         = "1.1.1.1.7 Ensure enhanced weak passcode detection is set to enabled (Manual)"
  description   = "For security purposes, Zoom has a few requirements that your passcode can meet. As per passcode requirements, Use enhanced weak passcode detection. This shall make the passcode strong."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.1.1.7"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (meeting_security -> 'meeting_password_requirement' -> 'weak_enhance_detection')::bool then 'ok'
        else 'alarm'
      end as status,
      'Enhanced weak password detection setting is ' || case when (meeting_security -> 'meeting_password_requirement' -> 'weak_enhance_detection')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_1_1_8" {
  title         = "1.1.1.1.8 Ensure only allow numeric passcode is set to disabled (Manual)"
  description   = "For security purposes, Zoom has a few requirements that your passcode must meet. As per passcode requirements, Disable \"Only allow numeric passcode”, enabling this shall make the passcode weaker."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.1.1.8"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (meeting_security -> 'meeting_password_requirement' -> 'only_allow_numeric')::bool then 'alarm'
        else 'ok'
      end as status,
      'Only allow numeric passcode setting is ' || case when (meeting_security -> 'meeting_password_requirement' -> 'only_allow_numeric')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_1_2" {
  title         = "1.1.1.2 Ensure waiting room is set to enabled (Manual)"
  description   = "When participants join a meeting, place them in a waiting room and require the host to admit them individually. Enabling the waiting room automatically disables the setting for allowing participants to join before host."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.1.2"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (meeting_security -> 'waiting_room')::bool then 'ok'
        else 'alarm'
      end as status,
      'Waiting room setting is ' || case when (meeting_security -> 'waiting_room')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_1_3" {
  title         = "1.1.1.3 Ensure waiting room options is set to everyone (Manual)"
  description   = "Click on \"Edit Options\" to choose who should go in the waiting room? A) Everyone, B) Users not in your account, C) Users who are not in your account and not part of the allowed domains."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.1.3"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (meeting_security -> 'waiting_room_settings' -> 'participants_to_place_in_waiting_room')::int = 0 then 'ok'
        else 'alarm'
      end as status,
      'Waiting room is enabled for ' ||
        case (meeting_security -> 'waiting_room_settings' -> 'participants_to_place_in_waiting_room')::int
          when 1 then 'Users not in your account'
          when 2 then 'Users who are not in your account and not part of the allowed domains'
          else 'Everyone' -- usually 0
        end ||
        '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_1_4" {
  title         = "1.1.1.4 Ensure require a passcode when scheduling new meetings is set to enabled (Manual)"
  description   = "Require a passcode when scheduling new meetings must be set to enabled. A passcode will be generated when scheduling a meeting and participants require the passcode to join the meeting."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.1.4"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (meeting_security -> 'meeting_password')::bool then 'ok'
        else 'alarm'
      end as status,
      'Meeting password is ' || case when (meeting_security -> 'meeting_password')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_1_5" {
  title         = "1.1.1.5 Ensure room meeting ID passcode is set to enabled (Manual)"
  description   = "All Room Meeting ID meetings that users can join via client, phone, or room systems will be passcode-protected."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.1.5"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = query.no_api_available.sql
}

control "cis_v100_1_1_1_6" {
  title         = "1.1.1.6 Ensure require a password for instant meetings is set to enabled (Manual)"
  description   = "A random passcode will be generated when starting an instant meeting."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.1.6"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = query.no_api_available.sql
}

control "cis_v100_1_1_1_7" {
  title         = "1.1.1.7 Ensure require a password for Personal Meeting ID (PMI) is set to enabled (Manual)"
  description   = "Enable \"Require a passcode for Personal Meeting ID (PMI)\" to set a passcode for meetings that use the personal meeting ID (PMI) and then choose \"All meetings using PMI\"."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.1.7"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (meeting_security -> 'pmi_password')::bool then 'ok'
        else 'alarm'
      end as status,
      'Meeting password is ' || case when (meeting_security -> 'pmi_password')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_1_8" {
  title         = "1.1.1.8 Ensure embed password in meeting link for one-click join is set to enabled (Manual)"
  description   = "Meeting passcode will be encrypted and included in the invite link to allow participants to join with just one click without having to enter the passcode."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.1.8"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (meeting_security -> 'embed_password_in_join_link')::bool then 'ok'
        else 'alarm'
      end as status,
      'Embed password in meeting link is ' || case when (meeting_security -> 'embed_password_in_join_link')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_1_9" {
  title         = "1.1.1.9 Ensure only authenticated users can join meetings is set to enabled (Manual)"
  description   = "The participants need to authenticate prior to joining the meetings."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.1.9"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (meeting_authentication -> 'enabled')::bool then 'ok'
        else 'alarm'
      end as status,
      'Only authenticated users can join meetings is ' || case when (meeting_authentication -> 'enabled')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_1_10" {
  title         = "1.1.1.10 Ensure require password for participants joining by phone is set to enabled (Manual)"
  description   = "A numeric passcode will be required for participants joining by phone if your meeting has a passcode. For meeting with an alphanumeric passcode, a numeric version will be generated."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.1.10"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (meeting_security -> 'phone_password')::bool then 'ok'
        else 'alarm'
      end as status,
      'Phone password is ' || case when (meeting_security -> 'phone_password')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_1_11" {
  title         = "1.1.1.11 Ensure only authenticated users can join meetings from Web client is set to enabled (Manual)"
  description   = "Only authenticated users can join meetings from Web client should be set to enabled. This requires users to authenticate and identify themselves prior to logging in and joining a meeting."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.1.10"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = query.no_api_available.sql
}
