
locals {
  cis_v100_1_1_2_common_tags = merge(local.cis_v100_common_tags, {
    cis_section_id = "1.1.2"
  })
}

benchmark "cis_v100_1_1_2" {
  title = "1.1.2 Schedule Meeting"
  children = [
    benchmark.cis_v100_1_1_2_1,
    control.cis_v100_1_1_2_2,
    control.cis_v100_1_1_2_3,
    control.cis_v100_1_1_2_4,
    control.cis_v100_1_1_2_5,
    control.cis_v100_1_1_2_6,
    control.cis_v100_1_1_2_7,
    control.cis_v100_1_1_2_8,
    control.cis_v100_1_1_2_9,
    control.cis_v100_1_1_2_10,
    control.cis_v100_1_1_2_11,
    control.cis_v100_1_1_2_12,
    control.cis_v100_1_1_2_13,
  ]

  tags = merge(local.cis_v100_1_1_2_common_tags, {
    service = "Zoom/Meeting"
    type    = "Benchmark"
  })
}

benchmark "cis_v100_1_1_2_1" {
  title = "1.1.2.1 Meeting password requirement"
  children = [
    control.cis_v100_1_1_2_1_1,
    control.cis_v100_1_1_2_1_2,
    control.cis_v100_1_1_2_1_3,
    control.cis_v100_1_1_2_1_4,
    control.cis_v100_1_1_2_1_5,
    control.cis_v100_1_1_2_1_6,
  ]

  tags = merge(local.cis_v100_1_1_2_common_tags, {
    type        = "Benchmark"
  })
}

control "cis_v100_1_1_2_1_1" {
  title       = "1.1.2.1.1 Have a minimum password length (Automated)"
  description = "For security purposes, Zoom has a few requirements that your password must meet. These apply when setting your initial password and when resetting your password. Minimum password length must be at least 8 characters."
  tags = merge(local.cis_v100_1_1_2_common_tags, {
    cis_item_id = "1.1.2.1.1"
    cis_type    = "automated"
    cis_level   = 1
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (schedule_meeting -> 'meeting_password_requirement' -> 'length')::int >= 8 then 'ok'
        else 'alarm'
      end as status,
      'Minimum password length set to ' || (schedule_meeting -> 'meeting_password_requirement' ->> 'length') || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_2_1_2" {
  title       = "1.1.2.1.2 Specify a password length: (Automated)"
  description = "For security purposes, Zoom has a few requirements that your password must meet. These apply when setting your initial password and when resetting your password. Password length must be at least 8 characters and cannot be longer than 32 characters."
  tags = merge(local.cis_v100_1_1_2_common_tags, {
    cis_item_id = "1.1.2.1.2"
    cis_type    = "automated"
    cis_level   = 1
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (schedule_meeting -> 'meeting_password_requirement' -> 'length')::int >= 8 and (schedule_meeting -> 'meeting_password_requirement' -> 'length')::int <= 32 then 'ok'
        else 'alarm'
      end as status,
      'Minimum password length set to ' || (schedule_meeting -> 'meeting_password_requirement' ->> 'length') || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_2_1_3" {
  title       = "1.1.2.1.3 Have at least 1 letter (a, b, c...) (Automated)"
  description = "For security purposes, Zoom has a few requirements that your password must meet. These apply when setting your initial password and when resetting your password. As per password requirements, have at least 1 letter (a, b, c...). This shall make the password strong."
  tags = merge(local.cis_v100_1_1_2_common_tags, {
    cis_item_id = "1.1.2.1.3"
    cis_type    = "automated"
    cis_level   = 1
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (schedule_meeting -> 'meeting_password_requirement' -> 'have_letter')::bool then 'ok'
        else 'alarm'
      end as status,
      'Have at least 1 letter setting is ' || case when (schedule_meeting -> 'meeting_password_requirement' -> 'have_letter')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_2_1_4" {
  title       = "1.1.2.1.4 Have at least 1 number (1, 2, 3...) (Automated)"
  description = "For security purposes, Zoom has a few requirements that your password must meet. These apply when setting your initial password and when resetting your password. As per password requirements, have at least 1 number (1, 2, 3...). This shall make the password strong."
  tags = merge(local.cis_v100_1_1_2_common_tags, {
    cis_item_id = "1.1.2.1.4"
    cis_type    = "automated"
    cis_level   = 1
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (schedule_meeting -> 'meeting_password_requirement' -> 'have_number')::bool then 'ok'
        else 'alarm'
      end as status,
      'Have at least 1 number setting is ' || case when (schedule_meeting -> 'meeting_password_requirement' -> 'have_number')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_2_1_5" {
  title       = "1.1.2.1.5 Have at least 1 special character (!, @, #...) (Manual)"
  description = "For security purposes, Zoom has a few requirements that your password must meet. These apply when setting your initial password and when resetting your password. As per password requirements, include at least 1 special character (!, @, #...)."
  tags = merge(local.cis_v100_1_1_2_common_tags, {
    cis_item_id = "1.1.2.1.5"
    cis_type    = "automated"
    cis_level   = 2
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (schedule_meeting -> 'meeting_password_requirement' -> 'have_special_character')::bool then 'ok'
        else 'alarm'
      end as status,
      'Have at least 1 special character setting is ' || case when (schedule_meeting -> 'meeting_password_requirement' -> 'have_special_character')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_2_1_6" {
  title       = "1.1.2.1.6 Include both uppercase and lower case letters (Automated)"
  description = "For security purposes, Zoom has a few requirements that your password must meet. These apply when setting your initial password and when resetting your password. As per password requirements, include both uppercase and lower case letters."
  tags = merge(local.cis_v100_1_1_2_common_tags, {
    cis_item_id = "1.1.1.1.6"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (schedule_meeting -> 'meeting_password_requirement' -> 'have_upper_and_lower_characters')::bool then 'ok'
        else 'alarm'
      end as status,
      'Have uppercase and lowercase characters is ' || case when (schedule_meeting -> 'meeting_password_requirement' -> 'have_upper_and_lower_characters')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_2_2" {
  title       = "1.1.2.2 Ensure host video is set to disabled (Manual)"
  description = "Start meetings with host video on should be set to disabled."
  tags = merge(local.cis_v100_1_1_2_common_tags, {
    cis_item_id = "1.1.2.2"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (schedule_meeting -> 'host_video')::bool then 'alarm'
        else 'ok'
      end as status,
      'Host Video On is ' || case when (schedule_meeting -> 'participants_video')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_2_3" {
  title       = "1.1.2.3 Ensure participants video is set to disabled (Manual)"
  description = "Start meetings with Participants video on should be set to disabled and locked off."
  tags = merge(local.cis_v100_1_1_2_common_tags, {
    cis_item_id = "1.1.2.3"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (schedule_meeting -> 'participants_video')::bool then 'alarm'
        else 'ok'
      end as status,
      'Participants Video On is ' || case when (schedule_meeting -> 'participants_video')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings

    union

    select
      -- Required Columns
      account_id as resource,
      case
        when (schedule_meeting -> 'participants_video')::bool then 'ok'
        else 'alarm'
      end as status,
      'Participants Video On setting is' || case when not (schedule_meeting -> 'participants_video')::bool then ' not' else '' end || ' locked.' as reason
    from
      zoom_account_lock_settings
  EOQ
}

control "cis_v100_1_1_2_4" {
  title       = "1.1.2.4 Ensure join before host is set to disabled (Automated)"
  description = "Allow participants to join the meeting before the host arrives should be set to disabled and locked off."
  tags = merge(local.cis_v100_1_1_2_common_tags, {
    cis_item_id = "1.1.2.4"
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (schedule_meeting -> 'join_before_host')::bool then 'alarm'
        else 'ok'
      end as status,
      'Join Before Host is ' || case when (schedule_meeting -> 'join_before_host')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings

    union

    select
      -- Required Columns
      account_id as resource,
      case
        when (schedule_meeting -> 'join_before_host')::bool then 'ok'
        else 'alarm'
      end as status,
      'Join Before Host setting is' || case when not (schedule_meeting -> 'join_before_host')::bool then ' not' else '' end || ' locked.' as reason
    from
      zoom_account_lock_settings
  EOQ
}

control "cis_v100_1_1_2_5" {
  title       = "1.1.2.5 Ensure enable personal meeting ID is set to enabled (Manual)"
  description = "A Personal Meeting ID (PMI) is a dedicated 9-11 digit number which is assigned to each individuals account. This becomes the users personal meeting room. This is the personal room assigned upon account creation."
  tags = merge(local.cis_v100_1_1_2_common_tags, {
    cis_item_id = "1.1.2.5"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (schedule_meeting -> 'personal_meeting')::bool then 'ok'
        else 'alarm'
      end as status,
      'Enable Personal Meeting ID is ' || case when (schedule_meeting -> 'personal_meeting')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_2_6" {
  title       = "1.1.2.6 Ensure use personal meeting ID (PMI) when scheduling a meeting is set to disabled (Manual)"
  description = "Use Personal Meeting ID (PMI) when scheduling a meeting should be set to disabled."
  tags = merge(local.cis_v100_1_1_2_common_tags, {
    cis_item_id = "1.1.2.6"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (schedule_meeting -> 'use_pmi_for_scheduled_meetings')::bool then 'ok'
        else 'alarm'
      end as status,
      'Use Personal Meeting ID (PMI) when scheduling a meeting is ' || case when (schedule_meeting -> 'use_pmi_for_scheduled_meetings')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_2_7" {
  title       = "1.1.2.7 Ensure use personal meeting ID (PMI) when starting an instant meeting is set to disabled (Manual)"
  description = "Use Personal Meeting ID (PMI) when starting an instant meeting should be set to disabled."
  tags = merge(local.cis_v100_1_1_2_common_tags, {
    cis_item_id = "1.1.2.7"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (schedule_meeting -> 'use_pmi_for_instant_meetings')::bool then 'ok'
        else 'alarm'
      end as status,
      'Use Personal Meeting ID (PMI) when starting an instant a meeting is ' || case when (schedule_meeting -> 'use_pmi_for_instant_meetings')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_2_8" {
  title       = "1.1.2.8 Ensure add watermark is set to enabled (Manual)"
  description = "Adding watermark enables author accreditation. Each attendee sees a portion of their own email address embedded as a watermark in any shared content and on the video of the participant who is sharing their screen. This option requires enabling \"Only signed-in users can join the meeting\" or \"Only signed-in users with specified domains can join meetings\"."
  tags = merge(local.cis_v100_1_1_2_common_tags, {
    cis_item_id = "1.1.2.8"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (in_meeting -> 'watermark')::bool then 'ok'
        else 'alarm'
      end as status,
      'Ensure add watermark is ' || case when (in_meeting -> 'watermark')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings

    union

    select
      -- Required Columns
      account_id as resource,
      case
        when (in_meeting -> 'watermark')::bool then 'ok'
        else 'alarm'
      end as status,
      'Ensure add watermark setting is' || case when not (in_meeting -> 'watermark')::bool then ' not' else '' end || ' locked.' as reason
    from
      zoom_account_lock_settings
  EOQ
}

control "cis_v100_1_1_2_9" {
  title       = "1.1.2.9 Ensure add audio watermark is set to enabled (Manual)"
  description = "Adding audio watermark, enables invisible accreditation. If an attendee records the meeting, their personal information will be embedded in the audio as an inaudible watermark. This option requires enabling \"Only signed-in users can join the meeting\" or \"Only signed-in users with specified domains can join meetings\"."
  tags = merge(local.cis_v100_1_1_2_common_tags, {
    cis_item_id = "1.1.2.9"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = query.no_api_available.sql
}

control "cis_v100_1_1_2_10" {
  title       = "1.1.2.10 Ensure always display \"Zoom Meeting\" as the meeting topic is set to enabled (Manual)"
  description = "Hide actual meeting topic and display \"Zoom Meeting\" for your scheduled meetings. Helps confidentiality of meeting topic public display."
  tags = merge(local.cis_v100_1_1_2_common_tags, {
    cis_item_id = "1.1.2.10"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (schedule_meeting -> 'not_store_meeting_topic')::bool then 'ok'
        else 'alarm'
      end as status,
      'Always display "Zoom Meeting" as the meeting topic is ' || case when (schedule_meeting -> 'not_store_meeting_topic')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings

    union

    select
      -- Required Columns
      account_id as resource,
      case
        when (schedule_meeting -> 'not_store_meeting_topic')::bool then 'ok'
        else 'alarm'
      end as status,
      'Always display "Zoom Meeting" as the meeting topic setting is' || case when not (schedule_meeting -> 'not_store_meeting_topic')::bool then ' not' else '' end || ' locked.' as reason
    from
      zoom_account_lock_settings
  EOQ
}

control "cis_v100_1_1_2_11" {
  title       = "1.1.2.11 Ensure bypass the password when joining meetings from meeting list is set to enabled (Manual)"
  description = "When Zoom Rooms join a scheduled meeting on its meeting list, users do not need to manually enter the meeting passcode."
  tags = merge(local.cis_v100_1_1_2_common_tags, {
    cis_item_id = "1.1.2.11"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = query.no_api_available.sql
}

control "cis_v100_1_1_2_12" {
  title       = "1.1.2.12 Ensure mute participants upon entry is set to enabled (Manual)"
  description = "Automatically mute all participants when they join the meeting. The host controls whether participants can unmute themselves, through client end by enabling \"Allow Participants to Unmute Themselves\" under more options in participants list."
  tags = merge(local.cis_v100_1_1_2_common_tags, {
    cis_item_id = "1.1.2.12"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (schedule_meeting -> 'mute_upon_entry')::bool then 'ok'
        else 'alarm'
      end as status,
      'Ensure mute participants upon entry is ' || case when (schedule_meeting -> 'mute_upon_entry')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings

    union

    select
      -- Required Columns
      account_id as resource,
      case
        when (schedule_meeting -> 'mute_upon_entry')::bool then 'ok'
        else 'alarm'
      end as status,
      'Ensure mute participants upon entry setting is' || case when not (schedule_meeting -> 'mute_upon_entry')::bool then ' not' else '' end || ' locked.' as reason
    from
      zoom_account_lock_settings
  EOQ
}

control "cis_v100_1_1_2_13" {
  title       = "1.1.2.13 Ensure upcoming meeting reminder is set to enabled (Manual)"
  description = "Enable this option to receive desktop notification for upcoming meetings. Reminder time can be configured in the Zoom Desktop Client."
  tags = merge(local.cis_v100_1_1_2_common_tags, {
    cis_item_id = "1.1.2.13"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = query.no_api_available.sql
}
