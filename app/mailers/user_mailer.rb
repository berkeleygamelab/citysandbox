class UserMailer < ActionMailer::Base
  
  def signup_notification(user, randomValue)
      recipients "#{user.login} <#{user.email}>"
      from       "appcivist "
      subject    "Please activate your new account"
      sent_on    Time.now
      body      "check it out! go to this link and yeah you'll be awesome! "
      #http://citysandbox.heroku.com/validate?token=#{randomValue}&user=#{user.id}
    end
end
