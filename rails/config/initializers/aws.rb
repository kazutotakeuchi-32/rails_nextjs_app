# Amazon SES
aws = Rails.application.credentials.aws
creds = Aws::Credentials.new(aws.access_key_id, aws.secret_access_key)

Aws::Rails.add_action_mailer_delivery_method(
  :ses,
  credentials: creds,
  region: 'ap-northeast-1'
)

