class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user #converts to user_url(user)
    else 
      flash.now[:danger] = 'Invalid email/password combo'
      render 'new'
    end
  end
  
  def destroy
    #should probably flash 'you have logged out' here
    log_out
    redirect_to root_url
  end
end
