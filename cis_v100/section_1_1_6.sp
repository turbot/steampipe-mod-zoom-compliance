
benchmark "cis_v100_1_1_6" {
  title         = "1.1.6 Email Notification"
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.6"
  })
  children = [
    benchmark.cis_v100_1_1_6_1,
    control.cis_v100_1_1_6_2,
    control.cis_v100_1_1_6_3,
    control.cis_v100_1_1_6_4,
    control.cis_v100_1_1_6_5,
    control.cis_v100_1_1_6_6,
  ]
}

benchmark "cis_v100_1_1_6_1" {
  title         = "1.1.6.1 When a cloud recording is available"
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.6.1"
  })
  children = [
    control.cis_v100_1_1_6_1_1,
    control.cis_v100_1_1_6_1_2,
    control.cis_v100_1_1_6_1_3,
  ]
}

control "cis_v100_1_1_6_1_1" {
  title         = "1.1.6.1.1 Ensure when a cloud recording is available is set to enabled (Manual)"
  description   = "Notify host when cloud recording is available. This can enable hosts to validate the recording for any confidential data, prior sharing the video at large."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.6.1.1"
    cis_type     = "manual"
    cis_level    = 1
  })
  sql = <<EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (email_notification -> 'cloud_recording_available_reminder')::bool then 'ok'
        else 'alarm'
      end as status,
      'Cloud recording available notification is ' || case when (email_notification -> 'cloud_recording_available_reminder')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_6_1_2" {
  title         = "1.1.6.1.2 Ensure Send a copy to the person who scheduled the meeting/webinar for the host is set to enabled (Manual)"
  description   = "Send a copy to the person who scheduled the meeting/webinar for the host. This can enable meeting scheduler to validate the recording for any confidential data prior sharing the video at large."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.6.1.2"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = query.no_api_available.sql
}

control "cis_v100_1_1_6_1_3" {
  title         = "1.1.6.1.3 Ensure send a copy to the Alternative Hosts is set to enabled (Manual)"
  description   = "Send a copy to the Alternative Hosts. This can enable alternate hosts to validate the recording for any confidential data prior sharing the video at large."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.6.1.3"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = query.no_api_available.sql
}

control "cis_v100_1_1_6_2" {
  title         = "1.1.6.2 Ensure when attendees join meeting before host is set to enabled (Manual)"
  description   = "Notify host when participants join the meeting before them."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.6.2"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (email_notification -> 'jbh_reminder')::bool then 'ok'
        else 'alarm'
      end as status,
      'Join before host notification is ' || case when (email_notification -> 'jbh_reminder')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_6_3" {
  title         = "1.1.6.3 Ensure when a meeting is cancelled is set to enabled (Manual)"
  description   = "Notify host and participants when the meeting is cancelled."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.6.3"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (email_notification -> 'jbh_reminder')::bool then 'ok'
        else 'alarm'
      end as status,
      'Meeting is cancelled notification is ' || case when (email_notification -> 'jbh_reminder')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_6_4" {
  title         = "1.1.6.4 Ensure when an alternative host is set or removed from a meeting is set to enabled (Manual)"
  description   = "When an alternative host is set or removed from a meeting, notify the alternative host who is set or removed."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.6.4"
    cis_type    = "manual"
    cis_level   = 2
  })
  sql = <<EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (email_notification -> 'alternative_host_reminder')::bool then 'ok'
        else 'alarm'
      end as status,
      'Alternative host change notification is ' || case when (email_notification -> 'alternative_host_reminder')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_6_5" {
  title         = "1.1.6.5 Enable when someone scheduled a meeting for a host is set to enabled (Manual)"
  description   = "When someone scheduled a meeting for a host, Notify the host there is a meeting is scheduled, rescheduled, or cancelled. Helpful in monitoring the schedule by someone who has permissions to schedule a meeting on behalf of host."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.6.5"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = <<EOQ
    select
      -- Required Columns
      account_id as resource,
      case
        when (email_notification -> 'schedule_for_reminder')::bool then 'ok'
        else 'alarm'
      end as status,
      'Scheduled for notification is ' || case when (email_notification -> 'schedule_for_reminder')::bool then 'enabled' else 'disabled' end || '.' as reason
    from
      zoom_account_settings
  EOQ
}

control "cis_v100_1_1_6_6" {
  title         = "1.1.6.6 Ensure when the cloud recording is going to be permanently deleted from trash is set to enabled (Manual)"
  description   = "When the cloud recording is going to be permanently deleted from trash, Notify the host 7 days before the cloud recording is permanently deleted from trash. This is helpful when there are needs to preserve the recordings as per the applicable data retention guidelines."
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "1.1.6.6"
    cis_type    = "manual"
    cis_level   = 1
  })
  sql = query.no_api_available.sql
}
