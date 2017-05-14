module SessionsHelper
  def log_in(user) #we make the login here so that we can use it in a few diff. places
    session[:user_id] = user.id
  end
  
  def current_user
    #Notice 'or equals'. So, if current user is not assigned, search thru database
    #for the user by the cookie details
    @current_user ||= User.find_by(id: session[:user_id]) 
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
