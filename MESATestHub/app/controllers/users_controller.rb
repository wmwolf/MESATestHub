class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :authorize_user
  before_action :authorize_admin, only: %i[new create admin destroy
                                           admin_edit_user admin_destroy_user]
  before_action :authorize_self_or_admin, only: %i[edit update]

  def index
    @users = User.all.order(:name)
  end

  def new
    @user = User.new
  end

  def show
    @computers = @user.computers
    @test_instances = @user.test_instances.order(
      mesa_version: :desc, created_at: :desc
    ).limit(20)
    @test_instance_classes = {}
    @test_instances.each do |instance| 
      @test_instance_classes[instance] = instance.passed ? 'table-success' : 'table-danger'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: "Successfully set up #{@user.name}."
    else
      render "new"
    end
  end

  def update
    respond_to do |format|
      # set custom params hash to make sure admin doesn't get spoofed
      update_params = {}
      user_params.each { |key, value| update_params[key] = value }

      # only admins can upgrade users to admin status
      # update_params['admin'] ||= false unless current_user.admin?

      # do update
      if @user.update(update_params)
        format.html do
          redirect_to @user, notice: "#{@user.name} was successfully updated."
        end
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def destroy
    # prevent bricking of session if destroying self
    session[:user_id] = nil if @user.id == current_user.id
    @user.destroy
    respond_to do |format|
      format.html do 
        redirect_to users_url, notice: 'User was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  def admin
    # for selecting from all users
    @users = User.all.order(:name)

    # for building a new user
    @user = User.new

    # for building a new test case
    @test_case = TestCase.new

    # for making select field for a new test case
    @modules = TestCase.modules

    render 'admin'
  end

  def admin_edit_user
    user = User.find(admin_edit_user_params[:user_id])
    if user
      redirect_to edit_user_path(user)
    else
      redirect_to admin_path, alert: 'Invalid User'
    end
  end

  def admin_destroy_user
    user = User.find(admin_edit_user_params[:user_id])
    if user
      # prevent bricking of session if destroying self
      session[:user_id] = nil if user.id == current_user.id
      user.destroy
      redirect_to admin_path, notice: 'User was successfully destroyed.'
    else
      redirect_to admin_path, alert: 'Invalid User'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :name, :admin)
  end

  def admin_edit_user_params
    params.permit(:user_id)
  end
end
