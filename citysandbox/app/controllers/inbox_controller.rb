class InboxController < ApplicationController
  def respond
    
      @message = current_user.message[params[:id]]
  end
  def index
    @messages = current_user.message_copys
  end
  
  def show
    
  end
  
  def new
    @message = current_user.messages[params[:id]]
  end
  
end
