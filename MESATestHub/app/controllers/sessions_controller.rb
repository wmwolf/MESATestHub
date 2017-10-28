class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:check_credentials]

  def new
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user && user.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "Logged in as #{user.name}."
    else
      flash.now[:error] = "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end

  def check_credentials
    user = User.find_by(email: session_params[:email])
    respond_to do |format|
      if user && user.authenticate(session_params[:password])
        # we're authenticated!
        format.html do
          # if in web site, just do a standard login
          session[:user_id] = user.id
          redirect_to root_url, notice: "Logged in as #{user.name}."
        end
        format.json do
          # if doing a JSON request, send back the all clear
          render json: { valid: true, message: "Email and password accepted." }
        end
      else
        # we are NOT authenticated
        format.html do
          flash.error = "Email or password is invalid"
          redirect_to login_path
        end
        format.json do
          render json: { valid: false, message: "Email or password are wrong."}
        end
      end
    end
  end


  private

  def session_params
    params.permit(:email, :password)
  end
end
