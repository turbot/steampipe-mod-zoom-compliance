locals {
  cis_v100_1_1_3_common_tags = merge(local.cis_v100_common_tags, {
    cis_section_id = "1.1.3"
  })
}

benchmark "cis_v100_1_1_3" {
  title         = "1.1.3 In Meeting (Basic)"
  children = [
    benchmark.cis_v100_1_1_3_1,
    benchmark.cis_v100_1_1_3_2,
    benchmark.cis_v100_1_1_3_3,
    benchmark.cis_v100_1_1_3_4,
    benchmark.cis_v100_1_1_3_5,
    benchmark.cis_v100_1_1_3_6,
    control.cis_v100_1_1_3_7,
    control.cis_v100_1_1_3_8,
    control.cis_v100_1_1_3_9,
    control.cis_v100_1_1_3_10,
    control.cis_v100_1_1_3_11,
    control.cis_v100_1_1_3_12,
    control.cis_v100_1_1_3_13,
    control.cis_v100_1_1_3_14,
    control.cis_v100_1_1_3_15,
    control.cis_v100_1_1_3_16,
    control.cis_v100_1_1_3_17,
    control.cis_v100_1_1_3_18,
    control.cis_v100_1_1_3_19,
    control.cis_v100_1_1_3_20,
    control.cis_v100_1_1_3_21,
  ]

  tags = merge(local.cis_v100_1_1_3_common_tags, {
    service = "Zoom/Meeting"
    type = "Benchmark"
  })
}

benchmark "cis_v100_1_1_3_1" {
  title         = "1.1.3.1"
  children = [
    control.cis_v100_1_1_3_1_1,
    control.cis_v100_1_1_3_1_2,
  ]

  tags = merge(local.cis_v100_1_1_3_common_tags, {
    service = "Zoom/Meeting"
    type = "Benchmark"
    cis_item_id = "1.1.3.1"
  })
}

control "cis_v100_1_1_3_1_1" {
  title         = "1.1.3.1.1 Ensure allow meeting participants to send a message visible to all participants is set to disabled (Manual)"
  description   = "Allow meeting participants to send a message visible to all participants. This can be further controlled from client end by the host / co-host."
  tags = merge(local.cis_v100_1_1_3_common_tags, {
    cis_item_id = "1.1.3.1.1"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (in_meeting -> 'chat')::bool then 'alarm'
        else 'ok'
      end as status,
      'Chat is ' || case when (in_meeting -> 'chat')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_3_1_2" {
  title         = "1.1.3.1.2 Ensure prevent participants from saving chat is set to enabled (Manual)"
  description   = "Prevent participants from saving chat, ensures that participants do not copy what is pasted in the zoom meeting chat."
  tags = merge(local.cis_v100_1_1_3_common_tags, {
    cis_item_id  = "1.1.3.1.2"
    cis_type     = "manual"
    cis_level    = 2
  })
  sql = query.no_api_available.sql
}

benchmark "cis_v100_1_1_3_2" {
  title         = "1.1.3.2 Sound notification when someone joins or leaves"
  children = [
    control.cis_v100_1_1_3_2_1,
    control.cis_v100_1_1_3_2_2,
    control.cis_v100_1_1_3_2_3,
  ]

  tags = merge(local.cis_v100_1_1_3_common_tags, {
    service = "Zoom/Meeting"
    type = "Benchmark"
    cis_item_id = "1.1.3.2"
  })
}

control "cis_v100_1_1_3_2_1" {
  title         = "1.1.3.2.1 Ensure sound notification when someone joins or leaves is set to enabled (Manual)"
  description   = "Enable \"Play sound when participants join or leave\". This can also be controlled from host client end if required to be changed."
  tags = merge(local.cis_v100_1_1_3_common_tags, {
    cis_item_id = "1.1.3.2.1"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when in_meeting ->> 'entry_exit_chime' = 'none' then 'alarm'
        else 'ok'
      end as status,
      'Play sound when participants join or leave is ' || (in_meeting ->> 'entry_exit_chime') || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_3_2_2" {
  title         = "1.1.3.2.2 Ensure play sound for \"Host and co-host only\" is set to enabled (Manual)"
  description   = "Change from \"Everyone\" option under [Play sound for] to \"Host and co-hosts only\"."
  tags = merge(local.cis_v100_1_1_3_common_tags, {
    cis_item_id = "1.1.3.2.2"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when in_meeting ->> 'entry_exit_chime' = 'host' then 'ok'
        else 'alarm'
      end as status,
      'Play sound for "Host and co-host only is ' || (in_meeting ->> 'entry_exit_chime') || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_3_2_3" {
  title         = "1.1.3.2.3 Ensure when someone joins by phone, ask to record their voice to use as the notification is set to enabled (Manual)"
  description   = "Select \"Ask to record their voice to use as the notification\" option for \"When someone joins by phone\"."
  tags = merge(local.cis_v100_1_1_3_common_tags, {
    cis_item_id = "1.1.3.2.3"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (in_meeting -> 'record_play_own_voice')::bool then 'ok'
        else 'alarm'
      end as status,
      'Ask to record voice as notification is ' || case when (in_meeting -> 'record_play_own_voice')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

benchmark "cis_v100_1_1_3_3" {
  title         = "1.1.3.3 File Transfer"
  children = [
    control.cis_v100_1_1_3_3_1,
    control.cis_v100_1_1_3_3_2,
  ]

  tags = merge(local.cis_v100_1_1_3_common_tags, {
    service = "Zoom/Meeting"
    type = "Benchmark"
    cis_item_id = "1.1.3.2"
  })
}

control "cis_v100_1_1_3_3_1" {
  title         = "1.1.3.3.1 Ensure hosts and participants can send files through the in-meeting chat is set to disabled (Manual)"
  description   = "Hosts and participants can send files through the in-meeting chat. As this is account level setting keep this enabled. If option of file transfer is required, then use it along with allowing specific file extension."
  tags = merge(local.cis_v100_1_1_3_common_tags, {
    cis_item_id = "1.1.3.3.1"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (in_meeting -> 'file_transfer')::bool then 'alarm'
        else 'ok'
      end as status,
      'File transfer is ' || case when (in_meeting -> 'file_transfer')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_3_3_2" {
  title         = "1.1.3.3.2 Ensure only allow specified file types is set to enabled (Manual)"
  description   = "Hosts and participants can send files through the in-meeting chat. And that too only the file types that are whitelisted. Provide the list of filetype that needs to be whitelisted e.g. .txt, .docx, .pdf, .xlsx"
  tags = merge(local.cis_v100_1_1_3_common_tags, {
    cis_item_id  = "1.1.3.3.2"
    cis_type     = "manual"
    cis_level    = 2
  })
  sql = query.no_api_available.sql
}

benchmark "cis_v100_1_1_3_4" {
  title         = "1.1.3.4 Screen sharing"
  children = [
    control.cis_v100_1_1_3_4_1,
    control.cis_v100_1_1_3_4_2,
    control.cis_v100_1_1_3_4_3,
  ]

  tags = merge(local.cis_v100_1_1_3_common_tags, {
    service = "Zoom/Meeting"
    type = "Benchmark"
    cis_item_id = "1.1.3.4"
  })
}

control "cis_v100_1_1_3_4_1" {
  title         = "1.1.3.4.1 Ensure screen sharing is set to enabled (Manual)"
  description   = "Allow host and participants to share their screen or content during meetings. Enable this option to ensure further options are customizable to control who can share screen or desktop audio."
  tags = merge(local.cis_v100_1_1_3_common_tags, {
    cis_item_id = "1.1.3.4.1"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (in_meeting -> 'screen_sharing')::bool then 'ok'
        else 'alarm'
      end as status,
      'Screen sharing is ' || case when (in_meeting -> 'screen_sharing')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_3_4_2" {
  title         = "1.1.3.4.2 Ensure \"who can share?\" is set to \"Host Only\" (Manual)"
  description   = "Select \"Who can share?\" as \"Host Only\" here. This can be controlled by host for a particular meeting at desktop client software."
  tags = merge(local.cis_v100_1_1_3_common_tags, {
    cis_item_id = "1.1.3.4.2"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when in_meeting ->> 'who_can_share_screen' = 'host' then 'ok'
        else 'alarm'
      end as status,
      'Who can share is ' || (in_meeting ->> 'who_can_share_screen') || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_3_4_3" {
  title         = "1.1.3.4.3 Ensure \"Who can start sharing when someone else is sharing?\" is set to \"Host Only\" (Manual)"
  description   = "This setting decides who can share screen when someone is already sharing. This option should be restricted to \"Host Only\". This can be changed or controlled by host for a particular meeting instance."
  tags = merge(local.cis_v100_1_1_3_common_tags, {
    cis_item_id = "1.1.3.4.3"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when in_meeting ->> 'who_can_share_screen_when_someone_is_sharing' = 'host' then 'ok'
        else 'alarm'
      end as status,
      'Who can share is ' || (in_meeting ->> 'who_can_share_screen_when_someone_is_sharing') || '.' as reason
    from
      zoom_account_settings
  EOQ
}

benchmark "cis_v100_1_1_3_5" {
  title         = "1.1.3.5 Annotation"
  tags = merge(local.cis_v100_1_1_3_common_tags, {
    cis_item_id = "1.1.3.5"
  })
  children = [
    control.cis_v100_1_1_3_5_1,
    control.cis_v100_1_1_3_5_2,
    control.cis_v100_1_1_3_5_3,
  ]
}

control "cis_v100_1_1_3_5_1" {
  title         = "1.1.3.5.1 Ensure annotation is set to disabled (Manual)"
  description   = "Allow host and participants to use annotation tools to add information to shared screens."
  tags = merge(local.cis_v100_1_1_3_common_tags, {
    cis_item_id = "1.1.3.5.1"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (in_meeting -> 'annotation')::bool then 'alarm'
        else 'ok'
      end as status,
      'Annotation tools are ' || case when (in_meeting -> 'annotation')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_3_5_2" {
  title         = "1.1.3.5.2 Ensure allow saving of shared screens with annotations is set to disabled (Manual)"
  description   = "Disable \"Allow saving of shared screens with annotations\"."
  tags = merge(local.cis_v100_1_1_3_common_tags, {
    cis_item_id  = "1.1.3.5.2"
    cis_type     = "manual"
    cis_level    = 2
  })
  sql = query.no_api_available.sql
}

control "cis_v100_1_1_3_5_3" {
  title         = "1.1.3.5.3 Ensure only the user who is sharing can annotate is set to enabled (Manual)"
  description   = "Enable \"Only the user who is sharing can annotate\", to ensure that only host can annotate."
  tags = merge(local.cis_v100_1_1_3_common_tags, {
    cis_item_id  = "1.1.3.5.3"
    cis_type     = "manual"
    cis_level    = 2
  })
  sql = query.no_api_available.sql
}

benchmark "cis_v100_1_1_3_6" {
  title         = "1.1.3.6 Whiteboard"
  children = [
    control.cis_v100_1_1_3_6_1,
    control.cis_v100_1_1_3_6_2,
    control.cis_v100_1_1_3_6_3,
  ]

  tags = merge(local.cis_v100_1_1_3_common_tags, {
    service = "Zoom/Meeting"
    type = "Benchmark"
    cis_item_id = "1.1.3.6"
  })
}

control "cis_v100_1_1_3_6_1" {
  title         = "1.1.3.6.1 Ensure whiteboard is set to disabled (Manual)"
  description   = "Allow host and participants to share whiteboard during a meeting."
  tags = merge(local.cis_v100_1_1_3_common_tags, {
    cis_item_id = "1.1.3.6.1"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (in_meeting -> 'whiteboard')::bool then 'alarm'
        else 'ok'
      end as status,
      'Whiteboard is ' || case when (in_meeting -> 'whiteboard')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_3_6_2" {
  title         = "1.1.3.6.2 Ensure allow saving of whiteboard content is set to disabled (Manual)"
  description   = "Allow host and participants to share whiteboard during a meeting. And also allow saving of whiteboard content. This can be controlled at meeting level."
  tags = merge(local.cis_v100_1_1_3_common_tags, {
    cis_item_id  = "1.1.3.6.2"
    cis_type     = "manual"
    cis_level    = 2
  })
  sql = query.no_api_available.sql
}

control "cis_v100_1_1_3_6_3" {
  title         = "1.1.3.6.3 Ensure auto save whiteboard content when sharing is stopped is set to disabled (Manual)"
  description   = "Allow host and participants to share whiteboard during a meeting. And disallow Auto save whiteboard content when sharing is stopped. This can be controlled at meeting level."
  tags = merge(local.cis_v100_1_1_3_common_tags, {
    cis_item_id  = "1.1.3.6.3"
    cis_type     = "manual"
    cis_level    = 2
  })
  sql = query.no_api_available.sql
}

control "cis_v100_1_1_3_7" {
  title         = "1.1.3.7 Ensure require encryption for 3rd party endpoints (SIP/H.323) is set to enabled (Manual)"
  description   = "By default, Zoom requires encryption for all data transferred between the Zoom cloud, Zoom client, and Zoom Room. Turn on this setting to require encryption for 3rd party endpoints (SIP/H.323) as well."
  tags = merge(local.cis_v100_1_1_3_common_tags, {
    cis_item_id = "1.1.3.7"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (in_meeting -> 'e2e_encryption')::bool then 'ok'
        else 'alarm'
      end as status,
      'Encryption for 3rd party endpoints is ' || case when (in_meeting -> 'e2e_encryption')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_3_8" {
  title         = "1.1.3.8 Ensure allow meeting participants to send a private 1:1 message to another participant is set to disabled (Manual)"
  description   = "Allow meeting participants to send a private 1:1 message to another participant."
  tags = merge(local.cis_v100_1_1_3_common_tags, {
    cis_item_id = "1.1.3.8"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (in_meeting -> 'private_chat')::bool then 'alarm'
        else 'ok'
      end as status,
      'Private chat is ' || case when (in_meeting -> 'private_chat')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_3_9" {
  title         = "1.1.3.9 Ensure auto saving chats is set to enabled (Manual)"
  description   = "Automatically save all in-meeting chats so that hosts do not need to manually save the text of the chat after the meeting starts."
  tags = merge(local.cis_v100_1_1_3_common_tags, {
    cis_item_id = "1.1.3.9"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (in_meeting -> 'auto_saving_chat')::bool then 'ok'
        else 'alarm'
      end as status,
      'Auto saving chats is ' || case when (in_meeting -> 'auto_saving_chat')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_3_10" {
  title         = "1.1.3.10 Ensure feedback to Zoom is set to enabled (Manual)"
  description   = "Add a Feedback tab to the Windows Settings or Mac Preferences dialog, and also enable users to provide feedback to Zoom at the end of the meeting."
  tags = merge(local.cis_v100_1_1_3_common_tags, {
    cis_item_id = "1.1.3.10"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (in_meeting -> 'feedback')::bool then 'ok'
        else 'alarm'
      end as status,
      'Feedback to Zoom is ' || case when (in_meeting -> 'feedback')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_3_11" {
  title         = "1.1.3.11 Ensure co-host is set to enabled (Manual)"
  description   = "Allow the host to add co-hosts. Co-hosts have the same in-meeting controls as the host."
  tags = merge(local.cis_v100_1_1_3_common_tags, {
    cis_item_id = "1.1.3.11"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (in_meeting -> 'co_host')::bool then 'ok'
        else 'alarm'
      end as status,
      'Add co-hosts is ' || case when (in_meeting -> 'co_host')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_3_12" {
  title         = "1.1.3.12 Ensure polling is set to enabled (Manual)"
  description   = "Add 'Polls' to the meeting controls. This allows the host to survey the attendees. Polls also enables the host to validate if participants are active."
  tags = merge(local.cis_v100_1_1_3_common_tags, {
    cis_item_id = "1.1.3.12"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (in_meeting -> 'polling')::bool then 'ok'
        else 'alarm'
      end as status,
      'Polling is ' || case when (in_meeting -> 'polling')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_3_13" {
  title         = "1.1.3.13 Ensure always show meeting control toolbar is set to enabled (Manual)"
  description   = "Always show meeting controls during a meeting. This helps in responding to situations where host / co-host need to quickly navigate controls to handle a situation."
  tags = merge(local.cis_v100_1_1_3_common_tags, {
    cis_item_id = "1.1.3.13"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (in_meeting -> 'show_meeting_control_toolbar')::bool then 'ok'
        else 'alarm'
      end as status,
      'Always show meeting control toolbar is ' || case when (in_meeting -> 'show_meeting_control_toolbar')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_3_14" {
  title         = "1.1.3.14 Ensure show Zoom windows during screen share is set to enabled (Manual)"
  description   = "Show Zoom windows during screen share. This shall help in quickly controlling a situation where someone needs to be muted/removed from the meeting."
  tags = merge(local.cis_v100_1_1_3_common_tags, {
    cis_item_id = "1.1.3.14"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (in_meeting -> 'allow_show_zoom_windows')::bool then 'ok'
        else 'alarm'
      end as status,
      'Show Zoom windows during screen share is ' || case when (in_meeting -> 'allow_show_zoom_windows')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_3_15" {
  title         = "1.1.3.15 Ensure disable desktop/screen share for users is set to enabled (Manual)"
  description   = "Disable desktop or screen share in a meeting and only allow sharing of selected applications."
  tags = merge(local.cis_v100_1_1_3_common_tags, {
    cis_item_id = "1.1.3.15"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = query.no_api_available.sql
}

control "cis_v100_1_1_3_16" {
  title         = "1.1.3.16 Ensure remote control is set to disabled (Manual)"
  description   = "During screen sharing, the person who is sharing can allow others to control the shared content."
  tags = merge(local.cis_v100_1_1_3_common_tags, {
    cis_item_id = "1.1.3.16"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (in_meeting -> 'remote_control')::bool then 'alarm'
        else 'ok'
      end as status,
      'Remote control is ' || case when (in_meeting -> 'remote_control')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_3_17" {
  title         = "1.1.3.17 Ensure nonverbal feedback is set to disabled (Manual)"
  description   = "Participants in a meeting can provide nonverbal feedback and express opinions by clicking on icons in the Participants panel. Disabling this avoids participants misusing this feature."
  tags = merge(local.cis_v100_1_1_3_common_tags, {
    cis_item_id = "1.1.3.17"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = query.no_api_available.sql
}

control "cis_v100_1_1_3_18" {
  title         = "1.1.3.18 Ensure meeting reactions is set to disabled (Manual)"
  description   = "Allow meeting participants to communicate without interrupting by reacting with an emoji that shows on their video. Reactions disappear after 10 seconds. Participants can change their reaction skin tone in Settings. This option can be misused by mischievous participants."
  tags = merge(local.cis_v100_1_1_3_common_tags, {
    cis_item_id = "1.1.3.18"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (in_meeting -> 'meeting_reactions')::bool then 'alarm'
        else 'ok'
      end as status,
      'Meeting reactions is ' || case when (in_meeting -> 'meeting_reactions')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_3_19" {
  title         = "1.1.3.19 Ensure allow removed participants to rejoin is set to disabled (Manual)"
  description   = "Allows previously removed meeting participants and webinar panelists to rejoin. If this option is enabled, then any distracting participants that were removed will be able to join back again."
  tags = merge(local.cis_v100_1_1_3_common_tags, {
    cis_item_id = "1.1.3.19"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = query.no_api_available.sql
}

control "cis_v100_1_1_3_20" {
  title         = "1.1.3.20 Ensure allow participants to rename themselves is set to enabled (Manual)"
  description   = "Allow meeting participants and webinar panelists to rename themselves. This option is required to identify participants in a meeting that does not require registration. Also, this options helps participants to rename themselves to self-identify."
  tags = merge(local.cis_v100_1_1_3_common_tags, {
    cis_item_id = "1.1.3.18"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (in_meeting -> 'allow_participants_to_rename')::bool then 'ok'
        else 'alarm'
      end as status,
      'Allow participants to rename themselves is ' || case when (in_meeting -> 'allow_participants_to_rename')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_3_21" {
  title         = "1.1.3.21 Ensure hide participant profile pictures in a meeting is set to disabled (Manual)"
  description   = "All participant profile pictures will be hidden and only the names of participants will be displayed on the video screen. Participants will not be able to update their profile pictures in the meeting."
  tags = merge(local.cis_v100_1_1_3_common_tags, {
    cis_item_id = "1.1.3.21"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = query.no_api_available.sql
}
