class SessionsController < ApplicationController

  def new
    #@session = Session.new
  end

  def create
    #@session = Session.new(session_params)
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy

  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

end
