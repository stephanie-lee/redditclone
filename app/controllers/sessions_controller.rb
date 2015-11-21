class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      user_params[:email],
      user_params[:password])

    if @user.nil?
      @user = User.new(email: user_params[:email])
      render :new
    else
      log_in!(@user)
      redirect_to subs_path
    end
  end

  def destroy
    log_out!
    redirect_to new_session_path
  end


  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
