
benchmark "cis_v100_1_2" {
  title       = "1.2 Recording"
  description = "Configure recording option in Zoom."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2"
  })
  children = [
    benchmark.cis_v100_1_2_1,
    benchmark.cis_v100_1_2_2,
    benchmark.cis_v100_1_2_3,
    benchmark.cis_v100_1_2_4,
    benchmark.cis_v100_1_2_5,
    benchmark.cis_v100_1_2_6,
    benchmark.cis_v100_1_2_7,
    control.cis_v100_1_2_8,
    control.cis_v100_1_2_9,
    control.cis_v100_1_2_10,
    control.cis_v100_1_2_11,
    control.cis_v100_1_2_12,
    control.cis_v100_1_2_13,
  ]
}

benchmark "cis_v100_1_2_1" {
  title         = "1.2.1 Local Recording"
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.1"
  })
  children = [
    control.cis_v100_1_2_1_1,
    control.cis_v100_1_2_1_2,
  ]
}

control "cis_v100_1_2_1_1" {
  title         = "1.2.1.1 Ensure local recording is set to enabled (Manual)"
  description   = "Allow hosts and participants to record the meeting to a local file."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.1.1"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<-EOQ
    select
      account_id as resource,
      case
        when (recording -> 'local_recording')::bool then 'ok'
        else 'alarm'
      end as status,
      'Local recording is ' || case when (recording -> 'local_recording')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_2_1_2" {
  title         = "1.2.1.2 Ensure hosts can give participants the permission to record locally is set to enabled (Manual)"
  description   = "Enable \"Hosts can give participants the permission to record locally\"."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.1.2"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = query.no_api_available.sql
}

benchmark "cis_v100_1_2_2" {
  title         = "1.2.2 Cloud Recording"
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.2"
  })
  children = [
    control.cis_v100_1_2_2_1,
    control.cis_v100_1_2_2_2,
    control.cis_v100_1_2_2_3,
    control.cis_v100_1_2_2_4,
    control.cis_v100_1_2_2_5,
    control.cis_v100_1_2_2_6,
  ]
}

control "cis_v100_1_2_2_1" {
  title         = "1.2.2.1 Ensure cloud recording is set to enabled (Manual)"
  description   = "Allow hosts to record and save the meeting / webinar in the cloud."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.2.1"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<-EOQ
    select
      account_id as resource,
      case
        when (recording -> 'cloud_recording')::bool then 'ok'
        else 'alarm'
      end as status,
      'Cloud recording is ' || case when (recording -> 'cloud_recording')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_2_2_2" {
  title         = "1.2.2.2 Ensure record active speaker with shared screen is set to enabled (Manual)"
  description   = "Record active speaker with shared screen."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.2.2"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<-EOQ
    select
      account_id as resource,
      case
        when (recording -> 'record_speaker_view')::bool then 'ok'
        else 'alarm'
      end as status,
      'Record active speaker with shared screen is ' || case when (recording -> 'record_speaker_view')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_2_2_3" {
  title         = "1.2.2.3 Ensure record gallery view with shared screen is set to enabled (Manual)"
  description   = "Record gallery view with shared screen."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.2.3"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<-EOQ
    select
      account_id as resource,
      case
        when (recording -> 'record_gallery_view')::bool then 'ok'
        else 'alarm'
      end as status,
      'Record gallery view with shared screen is ' || case when (recording -> 'record_gallery_view')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_2_2_4" {
  title         = "1.2.2.4 Ensure record active speaker, gallery view and shared screen separately is set to enabled (Manual)"
  description   = "Record active speaker, gallery view and shared screen separately. Useful to identify the participants, from various views at a later point in time for audit purpose."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.2.4"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = query.no_api_available.sql
}

control "cis_v100_1_2_2_5" {
  title         = "1.2.2.5 Ensure record an audio only file is set to enabled (Manual)"
  description   = "Record an audio only file. Useful in case of evidence for untampered audio file."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.2.5"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<-EOQ
    select
      account_id as resource,
      case
        when (recording -> 'record_audio_file')::bool then 'ok'
        else 'alarm'
      end as status,
      'Record audio file is ' || case when (recording -> 'record_audio_file')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_2_2_6" {
  title         = "1.2.2.6 Ensure save chat messages from the meeting / webinar is set to enabled (Manual)"
  description   = "Save chat messages from the meeting / webinar. Useful for any investigations."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.2.6"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<-EOQ
    select
      account_id as resource,
      case
        when (recording -> 'save_chat_text')::bool then 'ok'
        else 'alarm'
      end as status,
      'Save chat text is ' || case when (recording -> 'save_chat_text')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

benchmark "cis_v100_1_2_3" {
  title         = "1.2.3 Advanced cloud recording settings"
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.3"
  })
  children = [
    control.cis_v100_1_2_3_1,
    control.cis_v100_1_2_3_2,
    control.cis_v100_1_2_3_3,
    control.cis_v100_1_2_3_4,
    control.cis_v100_1_2_3_5,
  ]
}

control "cis_v100_1_2_3_1" {
  title         = "1.2.3.1 Ensure add a timestamp to the recording is set to enabled (Manual)"
  description   = "Add a timestamp to the recording by enabling this option."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.3.1"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<-EOQ
    select
      account_id as resource,
      case
        when (recording -> 'show_timestamp')::bool then 'ok'
        else 'alarm'
      end as status,
      'Add a timestamp to the recording is ' || case when (recording -> 'show_timestamp')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_2_3_2" {
  title         = "1.2.3.2 Ensure display participants' names in the recording is set to enabled (Manual)"
  description   = "This option display participants' names in the recording."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.3.2"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = query.no_api_available.sql
}

control "cis_v100_1_2_3_3" {
  title         = "1.2.3.3 Ensure record thumbnails when sharing is set to enabled (Manual)"
  description   = "Record thumbnails when sharing."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.3.3"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = query.no_api_available.sql
}

control "cis_v100_1_2_3_4" {
  title         = "1.2.3.4 Ensure optimize the recording for 3rd party video editor is set to enabled (Manual)"
  description   = "Optimize the recording for 3rd party video editor."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.3.4"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = query.no_api_available.sql
}

control "cis_v100_1_2_3_5" {
  title         = "1.2.3.5 Ensure save panelist chat to the recording is set to enabled (Manual)"
  description   = "Save panelist chat to the recording helps as chat audit."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.3.5"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = query.no_api_available.sql
}

benchmark "cis_v100_1_2_4" {
  title         = "1.2.4 Automatic recording"
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.4"
  })
  children = [
    control.cis_v100_1_2_4_1,
    control.cis_v100_1_2_4_2,
    control.cis_v100_1_2_4_3,
  ]
}

control "cis_v100_1_2_4_1" {
  title         = "1.2.4.1 Ensure automatic recording is set to enabled (Manual)"
  description   = "Record meetings automatically as they start. Allows to capture evidence if any incidents that happen at start of meetings."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.4.1"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<-EOQ
    select
      account_id as resource,
      case
        when (recording ->> 'auto_recording') <> 'none' then 'ok'
        else 'alarm'
      end as status,
      'Automatic recording is ' || (recording ->> 'auto_recording') || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_2_4_2" {
  title         = "1.2.4.2 Ensure automatic recording is set to \"Record in the Cloud\" (Manual)"
  description   = "Record meetings automatically as they start. This option allows to capture evidence if any incidents that happen at start of meetings. Now select \"Record in the cloud\" to preserve evidences."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.4.2"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<-EOQ
    select
      account_id as resource,
      case
        when (recording ->> 'auto_recording') = 'cloud' then 'ok'
        else 'alarm'
      end as status,
      'Automatic recording is ' || (recording ->> 'auto_recording') || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_2_4_3" {
  title         = "1.2.4.3 Ensure host can pause/stop the auto recording in the cloud is set to enabled (Manual)"
  description   = "Record meetings automatically as they start. This option allows to capture evidence if any incidents that happen at start of meetings."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.4.3"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = query.no_api_available.sql
}

benchmark "cis_v100_1_2_5" {
  title         = "1.2.5 Cloud recording downloads"
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.5"
  })
  children = [
    control.cis_v100_1_2_5_1,
    control.cis_v100_1_2_5_2,
  ]
}

control "cis_v100_1_2_5_1" {
  title         = "1.2.5.1 Ensure cloud recording downloads is set to enabled (Manual)"
  description   = "Allow anyone with a link to the cloud recording to download."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.5.1"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<-EOQ
    select
      account_id as resource,
      case
        when (recording -> 'cloud_recording_download')::bool then 'ok'
        else 'alarm'
      end as status,
      'Cloud recording downloads is ' || case when (recording -> 'cloud_recording_download')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_2_5_2" {
  title         = "1.2.5.2 Ensure only the host can download cloud recordings is set to enabled (Manual)"
  description   = "Enable \"Only the host can download cloud recordings\" option to block others to download the cloud recordings."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.5.2"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<-EOQ
    select
      account_id as resource,
      case
        when (recording -> 'cloud_recording_download_host')::bool then 'ok'
        else 'alarm'
      end as status,
      'Only the host can download cloud recordings is ' || case when (recording -> 'cloud_recording_download_host')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

benchmark "cis_v100_1_2_6" {
  title         = "1.2.6 Set minimum passcode strength requirements"
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.6"
  })
  children = [
    control.cis_v100_1_2_6_1,
    control.cis_v100_1_2_6_2,
    control.cis_v100_1_2_6_3,
    control.cis_v100_1_2_6_4,
    control.cis_v100_1_2_6_5,
  ]
}

control "cis_v100_1_2_6_1" {
  title         = "1.2.6.1 Ensure have a minimum passcode length is set to 8 characters or greater (Manual)"
  description   = "Have a minimum passcode length of 8 characters or greater."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.6.1"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (recording -> 'recording_password_requirement' -> 'length')::int >= 8 then 'ok'
        else 'alarm'
      end as status,
      'Minimum passcode length set to ' || (recording -> 'recording_password_requirement' ->> 'length') || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_2_6_2" {
  title         = "1.2.6.2 Ensure passcode have at least 1 letter is set to enabled (Manual)"
  description   = "Have at least 1 letter (a, b, c...)."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.6.2"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (recording -> 'recording_password_requirement' -> 'have_letter')::bool then 'ok'
        else 'alarm'
      end as status,
      'Have at least 1 letter setting is ' || case when (recording -> 'recording_password_requirement' -> 'have_letter')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_2_6_3" {
  title         = "1.2.6.3 Ensure passcode have at least 1 number is set to enabled (Manual)"
  description   = "Have at least 1 number (1, 2, 3...)."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.6.3"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (recording -> 'recording_password_requirement' -> 'have_number')::bool then 'ok'
        else 'alarm'
      end as status,
      'Have at least 1 number setting is ' || case when (recording -> 'recording_password_requirement' -> 'have_number')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_2_6_4" {
  title         = "1.2.6.4 Ensure passcode have at least 1 special character is set to enabled (Manual)"
  description   = "Have at least 1 special character (!, @, #...)."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.6.4"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (recording -> 'recording_password_requirement' -> 'have_special_character')::bool then 'ok'
        else 'alarm'
      end as status,
      'Have at least 1 special character setting is ' || case when (recording -> 'recording_password_requirement' -> 'have_special_character')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_2_6_5" {
  title         = "1.2.6.5 Ensure allow numeric passcode is set to disabled (Manual)"
  description   = "Disable \"Only allow numeric passcode\"."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.6.5"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (recording -> 'recording_password_requirement' -> 'only_allow_numeric')::bool then 'alarm'
        else 'ok'
      end as status,
      'Only allow numeric passcode is ' || case when (recording -> 'recording_password_requirement' -> 'have_special_character')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

benchmark "cis_v100_1_2_7" {
  title         = "1.2.7 Recording disclaimer"
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.7"
  })
  children = [
    control.cis_v100_1_2_7_1,
    control.cis_v100_1_2_7_2,
    control.cis_v100_1_2_7_3,
  ]
}

control "cis_v100_1_2_7_1" {
  title         = "1.2.7.1 Ensure recording disclaimer is set to enabled (Manual)"
  description   = "Show a customizable disclaimer to participants before a recording starts. Useful to address privacy requirements that mandates disclaimer prior recording starts."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.7.1"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (recording -> 'recording_disclaimer')::bool then 'ok'
        else 'alarm'
      end as status,
      'Recording disclaimer is ' || case when (recording -> 'recording_disclaimer')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_2_7_2" {
  title         = "1.2.7.2 Ensure ask participants for consent when a recording starts is set to enabled (Manual)"
  description   = "Ask participants for consent when a recording starts. Further click on \"Customize\" to modify the consent."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.7.2"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = query.no_api_available.sql
}

control "cis_v100_1_2_7_3" {
  title         = "1.2.7.3 Ensure ask host to confirm before starting a recording is set to enabled (Manual)"
  description   = "Ask host to confirm before starting a recording. Further click on \"Customize\" to modify the consent."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.7.3"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = query.no_api_available.sql
}

control "cis_v100_1_2_8" {
  title         = "1.2.8 Ensure prevent hosts from accessing their cloud recordings is set to enabled (Manual)"
  description   = "By turning on this setting, the hosts cannot view their meeting cloud recordings. Only the admins who have recording management privilege can access them."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.8"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (recording -> 'prevent_host_access_recording')::bool then 'ok'
        else 'alarm'
      end as status,
      'Prevent hosts from accessing their cloud recordings is ' || case when (recording -> 'prevent_host_access_recording')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_2_9" {
  title         = "1.2.9 Ensure IP address access control is set to organization approved ranges (Manual)"
  description   = "Allow cloud recording access only from specific IP address ranges. This option can enable certain IP address range within the organization, to allow download of recording. Once enabled, provide the IP ranges."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.9"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      'info' as status,
      'IP address access control is ' || case when (recording -> 'ip_address_access_control' -> 'enable')::bool then 'restricted to ' || (recording -> 'ip_address_access_control' ->> 'ip_addresses_or_ranges') else 'open to all IPs' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_2_10" {
  title         = "1.2.10 Ensure require passcode to access shared cloud recordings is set to enabled (Manual)"
  description   = "Passcode protection will be enforced for shared cloud recordings. A random passcode will be generated which can be modified by the users. This setting is applicable for newly generated recordings only."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.10"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (recording -> 'required_password_for_shared_cloud_recordings')::bool then 'ok'
        else 'alarm'
      end as status,
      'Require passcode to access shared cloud recordings is ' || case when (recording -> 'required_password_for_shared_cloud_recordings')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_2_11" {
  title         = "1.2.11 Ensure the host can delete cloud recordings is set to disabled (Manual)"
  description   = "Allow the host to delete the recordings. If this option is disabled, the recordings cannot be deleted by the host and only admin can delete them."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.11"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (recording -> 'host_delete_cloud_recording')::bool then 'alarm'
        else 'ok'
      end as status,
      'Host can delete cloud recordings is ' || case when (recording -> 'host_delete_cloud_recording')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_2_12" {
  title         = "1.2.12 Ensure allow recovery of deleted cloud recordings from trash is set to enabled (Manual)"
  description   = "Deleted cloud recordings will be kept in trash for 30 days. These files will not count as part of the total storage allowance. Useful when downloaded recordings are accidentally deleted."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.12"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<-EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (recording -> 'allow_recovery_deleted_cloud_recordings')::bool then 'ok'
        else 'alarm'
      end as status,
      'Host can delete cloud recordings is ' || case when (recording -> 'allow_recovery_deleted_cloud_recordings')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_2_13" {
  title         = "1.2.13 Ensure multiple audio notifications of recorded meeting is set to enabled (Manual)"
  description   = "Play notification messages to participants who join the meeting audio. These messages play each time the recording starts or restarts, informing participants that the meeting is being recorded. If participants join the audio from telephone, even if this option is disabled, users will hear one notification message per meeting. Useful to address privacy requirements that require recording disclaimer."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.2.13"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = query.no_api_available.sql
}
