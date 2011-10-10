class SentController < ApplicationController
  def index
     @messages = current_user.messages
   end

   def create
     @messages = current_user.messages
   end

   def new
     @messages = current_user.messages
   end

   def show
     @message = Message.create
     @message.user = current_user
     @message.subject = params[:subject]
     @message.body = params[:body]
     @message_send = MessageCopy.create
    
     @message_send.user = User.where(:login => params[:sendTo])[0]
     @success = "NAY!"
     if @message.save
       @success = "YAY!"
       @message_send.message = @message
       @message_send.save
     end
  end
    

end
