class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user= User.new(user_params)
    if @user.save
      log_in @user #from sessions_helper - log in the user
      flash[:success] = "Welcome to Brooklyn Lifting Club!"
      redirect_to @user #same as redirect_to user_url(@user)
    else
      render 'new'
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
