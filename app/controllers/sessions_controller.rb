class SessionsController < ApplicationController

  def new
    #@session = Session.new
  end

  def create
    #@session = Session.new(session_params)
    @user = User.find_by(email: session_params[:email].downcase)
    if @user && @user.authenticate(session_params[:password])
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_back_or @user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

end
