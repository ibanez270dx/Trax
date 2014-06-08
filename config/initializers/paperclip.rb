Paperclip::Attachment.default_options[:storage] = :s3
Paperclip::Attachment.default_options[:s3_protocol] = 'http'
Paperclip::Attachment.default_options[:s3_credentials] = {
  bucket: AMAZON_CONFIG[:bucket],
  access_key_id: AMAZON_CONFIG[:access_key_id],
  secret_access_key: AMAZON_CONFIG[:secret_access_key]
}
