module SessionsHelper
  # Logs in the given user
  def log_in(user)
    session[:user_id] = user.id
    # Guard against session replay attacks
    # See https://bit.ly/33UvK02 for more
    session[:session_token] = user.session_token
  end

  # Remembers a user in a persistent session
  def remember(user)
    user.remember
    cookies.permanent.encrypted[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Returns the current logged in user else nil
  def current_user
    if (user_id = session[:user_id])
      user = User.find_by(id: user_id)
      if user && session[:session_token] == user.session_token
        @current_user = user
      end
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      if user&.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user?(user)
    user && user == current_user
  end

  # Forgets a persistent session
  def forget_user(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget_user(current_user)
    reset_session
    @current_user = nil
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
