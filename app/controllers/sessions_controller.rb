class SessionsController < ApplicationController
  def new
    
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
    #should probably flash 'you have logged out' here
    log_out if logged_in?
    redirect_to root_url
  end
end

#params[:session][:remember_me] == '1' ? remember(user) : forget(user)
#Does this using ternary operator.  boolean? ? do_one_thing : do_something_else
#if params[:session][:remember_me] == '1'
#  remember(user)
#else
#  forget(user)
#end
#(it's for the checkbox to remember the user or not)
