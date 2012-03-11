class UserMailer < ActionMailer::Base
  
  def signup_notification(user, randomValue)
      recipients "#{user.login} <#{user.email}>"
      from       "appcivist "
      subject    "Please activate your new account [AppCivist]"
      sent_on    Time.now
      body      "Thanks for registering with AppCivist! Please go to this URL to verify your account: http://citysandbox.heroku.com/validate?token=#{randomValue}&user=#{user.id}"
    end
end
