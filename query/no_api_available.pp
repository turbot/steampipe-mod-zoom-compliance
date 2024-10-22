query "no_api_available" {
  sql = <<-EOQ
    select
      account_id as resource,
      'info' as status,
      'No API available, manual verification required.' as reason
    from
      zoom_my_user;
  EOQ
}