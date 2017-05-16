module SessionsHelper
  def log_in(user) #we make the login here so that we can use it in a few diff. places
    session[:user_id] = user.id
  end
  
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  #to end persistent session
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  #return user based on remember token cookie
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      #raise ###use raise to ensure that this block of code is being tested
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def logged_in? 
    !current_user.nil?
  end
  
  def log_out
    
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
  
  #redirects to stored locatoin (or default)
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end
  
  #store URL trying to be accessed
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
  
end
