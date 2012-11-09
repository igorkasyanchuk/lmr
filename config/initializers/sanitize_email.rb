SanitizeEmail::Config.configure do |config|
  config[:sanitized_to] = 'smoskov@softserveinc.com'
  config[:sanitized_cc] = 'smoskov@softserveinc.com'
  config[:sanitized_bcc] = 'smoskov@softserveinc.com'
  # sanitize emails from development and test, or set whatever logic should turn sanitize_email on and off here:
  config[:activation_proc] =   Proc.new { %w(development test).include?(Rails.env) }
  config[:use_actual_email_prepended_to_subject] = true   # or false
  config[:use_actual_email_as_sanitized_user_name] = true # or false
end