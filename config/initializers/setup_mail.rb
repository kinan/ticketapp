ActionMailer::Base.smtp_settings = {
  :address              => "smtp.domain.com",
  :port                 => 587,
  :domain               => "domain.com",
  :user_name            => "myname",
  :password             => "mypassword",
  :authentication       => "plain",
  :enable_starttls_auto => true
}
