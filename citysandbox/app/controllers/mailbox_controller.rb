class MailboxController < ApplicationController
  def show
     @messages = current_user.message_copys
  end

  def inbox
    @messages = current_user.message_copys
  end

end
