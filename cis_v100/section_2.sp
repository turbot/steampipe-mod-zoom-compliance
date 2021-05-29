
benchmark "cis_v100_2" {
  title         = "2 IM Management"
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "2"
  })
  children = [
    benchmark.cis_v100_2_1,
    control.cis_v100_2_2,
  ]
}

benchmark "cis_v100_2_1" {
  title         = "2.1 IM Settings"
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "2.1"
  })
  children = [
    benchmark.cis_v100_2_1_1,
    benchmark.cis_v100_2_1_2,
    benchmark.cis_v100_2_1_3,
    benchmark.cis_v100_2_1_4,
  ]
}

benchmark "cis_v100_2_1_1" {
  title         = "2.1.1 Sharing"
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "2.1.1"
  })
  children = [
    control.cis_v100_2_1_1_1,
    control.cis_v100_2_1_1_2,
    control.cis_v100_2_1_1_3,
    control.cis_v100_2_1_1_4,
  ]
}

control "cis_v100_2_1_1_1" {
  title       = "2.1.1.1 Ensure screen capture is set to disabled (Manual)"
  description = "Allow users to take and send screenshots in direct messages or group conversations. Reduces likelihood of data leakage through zoom screenshot sharing."
  sql = query.no_api_available.sql
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "2.1.1.1"
    cis_level = 2
  })
}

control "cis_v100_2_1_1_2" {
  title       = "2.1.1.2 Ensure code snippet is set to disabled (Manual)"
  description = "Allow users to send bits of code, configuration files, or log files in direct messages or group conversations. Reduces likelihood of data leakage through zoom screenshot sharing."
  sql = query.no_api_available.sql
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "2.1.1.2"
    cis_level = 2
  })
}

control "cis_v100_2_1_1_3" {
  title       = "2.1.1.3 Ensure animated GIF images is set to disabled (Manual)"
  description = "Allow users to search GIF images from Giphy. Reduces likelihood of data leakage through zoom screenshot sharing."
  sql = query.no_api_available.sql
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "2.1.1.3"
    cis_level = 2
  })
}

control "cis_v100_2_1_1_4" {
  title       = "2.1.1.4 Ensure file transfer is set to disabled (Manual)"
  description = "Allow users to send and receive files in direct messages or group conversations. Reduces likelihood of data leakage through zoom screenshot sharing."
  sql = query.no_api_available.sql
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "2.1.1.4"
    cis_level = 2
  })
}

benchmark "cis_v100_2_1_2" {
  title         = "2.1.2 Visibility"
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "2.1.2"
  })
  children = [
    control.cis_v100_2_1_2_1,
    control.cis_v100_2_1_2_2,
    control.cis_v100_2_1_2_3,
    control.cis_v100_2_1_2_4,
    control.cis_v100_2_1_2_5,
  ]
}

control "cis_v100_2_1_2_1" {
  title       = "2.1.2.1 Ensure set chat as a default tab for first-time users is set to disabled (Manual)"
  description = "By enabling this option, the default tab for first-time users will be switched from Home to Chat."
  sql = query.no_api_available.sql
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "2.1.2.1"
    cis_level = 2
  })
}

control "cis_v100_2_1_2_2" {
  title       = "2.1.2.2 Ensure show H.323 contacts is set to disabled (Manual)"
  description = "By enabling this option, the user's H.323 contacts will be displayed in the contact's list."
  sql = query.no_api_available.sql
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "2.1.2.2"
    cis_level = 2
  })
}

control "cis_v100_2_1_2_3" {
  title       = "2.1.2.3 Ensure company contacts is set to disabled (Manual)"
  description = "In your Zoom applications, the Contacts list will display all members of your account."
  sql = query.no_api_available.sql
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "2.1.2.3"
    cis_level = 2
  })
}

control "cis_v100_2_1_2_4" {
  title       = "2.1.2.4 Ensure IM groups is set to enabled (Manual)"
  description = "In your Zoom applications, the Contacts list will display all members of your account. For \"Account Management -> IM Management -> IM Groups\" option to work, this option need to be enabled."
  sql = query.no_api_available.sql
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "2.1.2.4"
    cis_level = 2
  })
}

control "cis_v100_2_1_2_5" {
  title       = "2.1.2.5 Ensure announcements is set to disabled (Manual)"
  description = "Allow specified users to send one-way announcements to everyone in the same account."
  sql = query.no_api_available.sql
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "2.1.2.5"
    cis_level = 2
  })
}

benchmark "cis_v100_2_1_3" {
  title         = "2.1.3 Security"
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "2.1.3"
  })
  children = [
    control.cis_v100_2_1_3_1,
    control.cis_v100_2_1_3_2,
    control.cis_v100_2_1_3_3,
    control.cis_v100_2_1_3_4,
    control.cis_v100_2_1_3_5,
  ]
}

control "cis_v100_2_1_3_1" {
  title       = "2.1.3.1 Ensure enable advanced chat encryption is set to enabled (Manual)"
  description = "Add an additional layer of encryption. Note that some features such as chat archives will be unavailable if this feature is enabled."
  sql = query.no_api_available.sql
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "2.1.3.1"
    cis_level = 2
  })
}

control "cis_v100_2_1_3_2" {
  title       = "2.1.3.2 Ensure enable personal channel in chat window is set to disabled (Manual)"
  description = "A personal channel allows users to save their private notes, action items, links, and files."
  sql = query.no_api_available.sql
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "2.1.3.2"
    cis_level = 2
  })
}

control "cis_v100_2_1_3_3" {
  title       = "2.1.3.3 Ensure allow users to add contacts is set to disabled (Manual)"
  description = "By disabling this setting, users will not be able to add contacts. If this option is required to be enabled, then choose \"Only in the same organization and specified domains\" and specify the domains for better security."
  sql = query.no_api_available.sql
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "2.1.3.3"
    cis_level = 2
  })
}

control "cis_v100_2_1_3_4" {
  title       = "2.1.3.4 Ensure allow users to chat with others is set to disabled (Manual)"
  description = "If you select \"Only in the same organization\", users may still be able to chat with external users if they are added to channels or group chats with external users. If this option is required to be enabled, then choose \"Only in the same organization and specified domains\" and specify the domains for better security."
  sql = query.no_api_available.sql
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "2.1.3.4"
    cis_level = 2
  })
}

control "cis_v100_2_1_3_5" {
  title       = "2.1.3.5 Ensure show status to external contacts is set to disabled (Manual)"
  description = "Status indicates the current availability (Available, Away, Do Not Disturb, In a Zoom meeting, Presenting) of users to their contacts. Choose whether or not external contacts can see your users' statuses."
  sql = query.no_api_available.sql
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "2.1.3.5"
    cis_level = 2
  })
}

benchmark "cis_v100_2_1_4" {
  title         = "2.1.4 Storage"
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "2.1.4"
  })
  children = [
    control.cis_v100_2_1_4_1,
    control.cis_v100_2_1_4_2,
    control.cis_v100_2_1_4_3,
    control.cis_v100_2_1_4_4,
  ]
}

control "cis_v100_2_1_4_1" {
  title       = "2.1.4.1 Ensure cloud storage is set to enabled (Manual)"
  description = "Save messages and files on the cloud for the specified period of time. Select the number of years to store the data as per local laws."
  sql = query.no_api_available.sql
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "2.1.4.1"
    cis_level = 2
  })
}

control "cis_v100_2_1_4_2" {
  title       = "2.1.4.2 Ensure delete local data is set to disabled (Manual)"
  description = "Specify how long your messages and files are saved on the local device."
  sql = query.no_api_available.sql
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "2.1.4.2"
    cis_level = 2
  })
}

control "cis_v100_2_1_4_3" {
  title       = "2.1.4.3 Ensure store edited and deleted message revisions is set to disabled (Manual)"
  description = "Keep the original versions of edited and deleted messages on the Chat History tab."
  sql = query.no_api_available.sql
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "2.1.4.3"
    cis_level = 2
  })
}

control "cis_v100_2_1_4_4" {
  title       = "2.1.4.4 Ensure third party archiving is set to disabled (Manual)"
  description = "Archive messages and files with a third party archiving service. Set up your account to send data to your archiving provider here."
  sql = query.no_api_available.sql
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "2.1.4.4"
    cis_level = 2
  })
}

control "cis_v100_2_2" {
  title       = "2.2 Enable IM groups is set to the organization's needs (Manual)"
  description = "IM Groups will be displayed in the Contacts section of your Zoom client. Creates groups as required."
  sql = query.no_api_available.sql
  tags = merge(local.cis_v100_common_tags, {
    cis_item_id = "2.2"
    cis_level = 2
  })
}
