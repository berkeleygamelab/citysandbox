class UserMailer < ActionMailer::Base
  def signup_notification(user)
      recipients "#{user.login} <#{user.email}>"
      from       "appcivist "
      subject    "Please activate your new account"
      sent_on    Time.now
      body       { :user => user, :url => activate_url(user.activation_code, :host => user.site.host }
    end
end
