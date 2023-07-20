class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # login
    else
      # invalid login
      flash[:danger] = 'Invalid email/password combination'
      render 'new', status: :unprocessable_entity
    end
  end
end
