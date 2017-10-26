class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user
  before_action :authorize_admin, only: [:new, :create, :admin, :destroy]
  before_action :authorize_self_or_admin, only: [:edit, :update]

  def index
    @users = User.all.order(:name)
  end

  def new
    @user = User.new
  end

  def show
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url, notice: "Successfully set up #{@user.name}."
    else
      render "new"
    end
  end

  def update
  end

  def edit
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def admin
    render "admin"
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def authorize_self_or_admin
    unless admin? or @user.id == current_user.id
      redirect_to login_url, alert: "Must be an admin or the user in " +
      "question to do that action."
    end
  end

end
