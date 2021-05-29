
benchmark "cis_v100_1_1_4" {
  title         = "1.1.4 In Meeting (Advanced)"
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.4"
  })
  children = [
    benchmark.cis_v100_1_1_4_1,
    benchmark.cis_v100_1_1_4_2,
    benchmark.cis_v100_1_1_4_3,
    benchmark.cis_v100_1_1_4_4,
    control.cis_v100_1_1_4_5,
    control.cis_v100_1_1_4_6,
    control.cis_v100_1_1_4_7,
    control.cis_v100_1_1_4_8,
    control.cis_v100_1_1_4_9,
    control.cis_v100_1_1_4_10,
    control.cis_v100_1_1_4_11,
    control.cis_v100_1_1_4_12,
    control.cis_v100_1_1_4_13,
    control.cis_v100_1_1_4_14,
    control.cis_v100_1_1_4_15,
    control.cis_v100_1_1_4_16,
    control.cis_v100_1_1_4_17,
  ]
}

benchmark "cis_v100_1_1_4_1" {
  title         = "1.1.4.1 Select data center regions for meetings/webinars hosted by your account"
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.4.1"
  })
  children = [
    control.cis_v100_1_1_4_1_1,
    control.cis_v100_1_1_4_1_2,
  ]
}

control "cis_v100_1_1_4_1_1" {
  title         = "1.1.4.1.1 Ensure select data center regions for meetings/webinars hosted by your account is set to enabled (Manual)"
  description   = "Include all data center regions to provide the best experience for participants joining from all regions. Opting out of data center regions may limit CRC, Dial-in, Call Me, and Invite by Phone options for participants joining from those regions."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.4.1.1"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<EOQ
    select
      account_id as resource,
      case
        when (meeting_security -> 'approved_or_denied_countries_or_regions' -> 'enable')::bool then 'ok'
        else 'alarm'
      end as status,
      'Entry for users from specific countries/regions is ' || case when (meeting_security -> 'approved_or_denied_countries_or_regions' -> 'enable')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_4_1_2" {
  title         = "1.1.4.1.2 Ensure data center regions is set to local countries (Manual)"
  description   = "Not all data centers are configured. Only the required ones are configured. Choose local or trusted region data centers."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.4.1.2"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<EOQ
    select
      account_id as resource,
      case
        when meeting_security -> 'approved_or_denied_countries_or_regions' ->> 'method' = 'approve' then 'ok'
        else 'alarm'
      end as status,
      'Method is ' || coalesce(meeting_security -> 'approved_or_denied_countries_or_regions' ->> 'method', 'not set') || '.' as reason
    from
      zoom_account_settings

    union

    select
      a.account_id as resource,
      'info' as status,
      cc || ' is set.' as reason
    from
      zoom_account_settings as a,
      jsonb_array_elements_text(meeting_security -> 'approved_or_denied_countries_or_regions' -> 'approved_list') as cc
  EOQ
}

benchmark "cis_v100_1_1_4_2" {
  title         = "1.1.4.2 Breakout room"
  description   = "Breakout rooms allow you to split your Zoom meeting in up to 50 separate sessions. The meeting host can choose to split the participants of the meeting into these separate sessions automatically or manually, and can switch between sessions at any time."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.4.2"
  })
  children = [
    control.cis_v100_1_1_4_2_1,
    control.cis_v100_1_1_4_2_2,
  ]
}

control "cis_v100_1_1_4_2_1" {
  title         = "1.1.4.2.1 Ensure breakout room is set to enabled (Manual)"
  description   = "Allow host to split meeting participants into separate, smaller rooms. This is beneficial, when participants need to be moved to separate virtual rooms."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.4.2.1"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<EOQ
    select
      account_id as resource,
      case
        when (in_meeting -> 'breakout_room')::bool then 'ok'
        else 'alarm'
      end as status,
      'Breakout room is ' || case when (in_meeting -> 'breakout_room')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_4_2_2" {
  title         = "1.1.4.2.2 Ensure allow host to assign participants to breakout rooms when scheduling is set to enabled (Manual)"
  description   = "Allow host to assign participants to breakout rooms when scheduling."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.4.2.2"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = query.no_api_available.sql
}

benchmark "cis_v100_1_1_4_3" {
  title         = "1.1.4.3 Virtual background"
  description   = "The Virtual Background feature allows you to display an image or video as your background during a Zoom Meeting."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.4.3"
  })
  children = [
    control.cis_v100_1_1_4_3_1,
    control.cis_v100_1_1_4_3_2,
    control.cis_v100_1_1_4_3_3,
  ]
}

control "cis_v100_1_1_4_3_1" {
  title         = "1.1.4.3.1 Ensure virtual background is set to enabled (Manual)"
  description   = "Customize your background to keep your environment private from others in a meeting. This can be used with or without a green screen."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.4.3.1"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<EOQ
    select
      account_id as resource,
      case
        when (in_meeting -> 'virtual_background')::bool then 'ok'
        else 'alarm'
      end as status,
      'Virtual background is ' || case when (in_meeting -> 'virtual_background')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_4_3_2" {
  title         = "1.1.4.3.2 Ensure allow use of videos for virtual backgrounds is set to disabled (Manual)"
  description   = "Customize your background to keep your environment private from others in a meeting. This can be used with or without a green screen. Allow use of videos for virtual backgrounds."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.4.3.2"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<EOQ
    select
      account_id as resource,
      case
        when (in_meeting -> 'virtual_background_settings' -> 'allow_videos')::bool then 'alarm'
        else 'ok'
      end as status,
      'Virtual background videos are ' || case when (in_meeting -> 'virtual_background_settings' -> 'allow_videos')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_4_3_3" {
  title         = "1.1.4.3.3 Ensure allow users to upload custom backgrounds is set to disabled (Manual)"
  description   = "Customize your background to keep your environment private from others in a meeting. This can be used with or without a green screen. Allow users to upload custom backgrounds. Disabling this option ensures that participants do not have inappropriate backgrounds."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.4.3.3"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<EOQ
    select
      account_id as resource,
      case
        when (in_meeting -> 'virtual_background_settings' -> 'allow_upload_custom')::bool then 'alarm'
        else 'ok'
      end as status,
      'Upload custom backgrounds is ' || case when (in_meeting -> 'virtual_background_settings' -> 'allow_upload_custom')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

benchmark "cis_v100_1_1_4_4" {
  title         = "1.1.4.4 Peer to Peer connection while only 2 people in a meeting"
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.4.4"
  })
  children = [
    control.cis_v100_1_1_4_4_1,
    control.cis_v100_1_1_4_4_2,
  ]
}

control "cis_v100_1_1_4_4_1" {
  title         = "1.1.4.4.1 Ensure peer to peer connection while only 2 people in a meeting is set to disabled (Manual)"
  description   = "Allow users to directly connect to one another in a 2-person meeting."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.4.4.1"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<EOQ
    select
      account_id as resource,
      case
        -- Note: p2p_connetion is spelt incorrectly in the API response
        when (in_meeting -> 'p2p_connetion')::bool then 'alarm'
        else 'ok'
      end as status,
      'Peer to peer connection is ' || case when (in_meeting -> 'p2p_connetion')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_4_4_2" {
  title         = "1.1.4.4.2 Enable listening ports range is set as appropriate for organization (Manual)"
  description   = "Listening ports range, select the appropriate ports as per your company or organization settings."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.4.4.2"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<EOQ
    select
      account_id as resource,
      case
        when (in_meeting -> 'p2p_ports')::bool then 'alarm'
        else 'ok'
      end as status,
      'Peer to peer ports is ' || case when (in_meeting -> 'p2p_connetion')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings

    union

    select
      account_id as resource,
      'info' as status,
      'Peer to peer ports range is set to ' || (in_meeting ->> 'ports_range') || '.' as reason
    from
      zoom_account_settings
    where
      (in_meeting ->> 'ports_range') <> ''
  EOQ
}

control "cis_v100_1_1_4_5" {
  title         = "1.1.4.5 Ensure report participants to Zoom is set to enabled (Manual)"
  description   = "Hosts can report meeting participants for inappropriate behavior to Zoom's Trust and Safety team for review. This setting can be found on the Security icon on the meeting controls toolbar."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.4.5"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = query.no_api_available.sql
}

control "cis_v100_1_1_4_6" {
  title         = "1.1.4.6 Ensure remote support is set to disabled (Manual)"
  description   = "Allow meeting host to provide 1:1 remote support to another participant. Do not enable these options unless, you really need them."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.4.6"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = query.no_api_available.sql
}

control "cis_v100_1_1_4_7" {
  title         = "1.1.4.7 Ensure closed captioning is set to disabled (Manual)"
  description   = "Allow host to type closed captions or assign a participant/third party device to add closed captions."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.4.7"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<EOQ
    select
      account_id as resource,
      case
        when (in_meeting -> 'closed_caption')::bool then 'alarm'
        else 'ok'
      end as status,
      'Closed captioning is ' || case when (in_meeting -> 'closed_caption')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_4_8" {
  title         = "1.1.4.8 Ensure save captions is set to disabled (Manual)"
  description   = "Allow participants to save fully closed captions or transcripts."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.4.8"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = query.no_api_available.sql
}

control "cis_v100_1_1_4_9" {
  title         = "1.1.4.9 Ensure far end camera control is set to disabled (Manual)"
  description   = "Allow another user to take control of your camera during a meeting. Both users (the one requesting control and the one giving control) must have this option turned on."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.4.9"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<EOQ
    select
      account_id as resource,
      case
        when (in_meeting -> 'far_end_camera_control')::bool then 'alarm'
        else 'ok'
      end as status,
      'Far end camera control is ' || case when (in_meeting -> 'far_end_camera_control')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_4_10" {
  title         = "1.1.4.10 Ensure identify guest participants in the meeting/webinar is set to enabled (Manual)"
  description   = "Participants who belong to your account can see that a guest (someone who does not belong to your account) is participating in the meeting/webinar. The Participants list indicates which attendees are guests. The guests themselves do not see that they are listed as guests."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.4.10"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = query.no_api_available.sql
}

control "cis_v100_1_1_4_11" {
  title         = "1.1.4.11 Ensure auto-answer group in chat is set to disabled (Manual)"
  description   = "Enable users to see and add contacts to 'auto-answer group' in the contact list on chat. Any call from members of this group will be automatically answered."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.4.11"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<EOQ
    select
      account_id as resource,
      case
        when (in_meeting -> 'auto_answer')::bool then 'alarm'
        else 'ok'
      end as status,
      'Auto-answer group in chat is ' || case when (in_meeting -> 'auto_answer')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_4_12" {
  title         = "1.1.4.12 Ensure only show default email when sending email invites is set to enabled (Manual)"
  description   = "Allow users to invite participants by email only by using the default email program selected on their computer."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.4.12"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<EOQ
    select
      account_id as resource,
      case
        when (in_meeting -> 'sending_default_email_invites')::bool then 'ok'
        else 'alarm'
      end as status,
      'Only show default email when sending email invites is ' || case when (in_meeting -> 'sending_default_email_invites')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_4_13" {
  title         = "1.1.4.13 Ensure use HTML format email for Outlook plugin is set to enabled (Manual)"
  description   = "Use HTML formatting instead of plain text for meeting invitations scheduled with the Outlook plugin."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.4.13"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<EOQ
    select
      account_id as resource,
      case
        when (in_meeting -> 'use_html_format_email')::bool then 'ok'
        else 'alarm'
      end as status,
      'Use HTML format email for Outlook plugin is ' || case when (in_meeting -> 'use_html_format_email')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_4_14" {
  title         = "1.1.4.14 Ensure show a \"Join from your browser\" link is set to enabled (Manual)"
  description   = "Allow participants to bypass the Zoom application download process, and join a meeting directly from their browser. This is a workaround for participants who are unable to download, install, or run applications. Note that the meeting experience from the browser is limited."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.4.14"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<EOQ
    select
      account_id as resource,
      case
        when (in_meeting -> 'show_a_join_from_your_browser_link')::bool then 'ok'
        else 'alarm'
      end as status,
      'Show a "Join from your browser" link is ' || case when (in_meeting -> 'show_a_join_from_your_browser_link')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_4_15" {
  title         = "1.1.4.15 Ensure allow live streaming meetings is set to disabled (Manual)"
  description   = "Allow live streaming meetings. Select Facebook Or Workplace by Facebook Or Youtube Or Custom Live Streaming Service."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.4.15"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<EOQ
    select
      account_id as resource,
      case
        when (in_meeting -> 'allow_live_streaming')::bool then 'alarm'
        else 'ok'
      end as status,
      'Allow live streaming meetings is ' || case when (in_meeting -> 'allow_live_streaming')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_4_16" {
  title         = "1.1.4.16 Ensure allow Skype for Business (Lync) client to join a Zoom meeting is set to disabled (Manual)"
  description   = "Allow internal or external Skype for Business (Lync) client to connect to a Zoom meeting."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.4.16"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = query.no_api_available.sql
}

control "cis_v100_1_1_4_17" {
  title         = "1.1.4.17 Ensure request permission to unmute is set to enabled (Manual)"
  description   = "Select this option in the scheduler to request permission to unmute meeting participants and webinar panelists. Permissions, once given, will apply in all meetings scheduled by the same person."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.4.17"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<EOQ
    select
      account_id as resource,
      case
        when (in_meeting -> 'request_permission_to_unmute_participants')::bool then 'ok'
        else 'alarm'
      end as status,
      'Request permission to unmute is ' || case when (in_meeting -> 'request_permission_to_unmute_participants')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}
