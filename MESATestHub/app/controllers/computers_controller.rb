class ComputersController < ApplicationController
  before_action :set_user, only: %i[show new create index edit update destroy
                                    test_instances_index]
  before_action :set_computer, only: %i[show edit update destroy
                                        test_instances_index]
  before_action :authorize_self_or_admin, only: %i[new create edit update
                                                   destroy]
  before_action :authorize_admin, only: %i[index_all]

  skip_before_action :verify_authenticity_token, only: [:check_computer]

  # GET /computers
  # GET /computers.json
  def index
    @owner_prefix = "#{@user.name}'s"
    @computers = @user.computers
  end

  def index_all
    @owner_prefix = 'All'
    @computers = Computer.all
    # @computers.sort_by { |c| c.user.name }
    render 'index'
  end

  # GET /computers/1/test_instances
  # GET /computers/1/test_instances.json
  def test_instances_index
    @computer_instances = @computer.test_instances.order(mesa_version: :desc)
  end

  # GET /computers/1
  # GET /computers/1.json
  def show
    @test_instances = @computer.test_instances.order(
      mesa_version: :desc, created_at: :desc
    ).limit(20)
    @test_instance_classes = {}
    @test_instances.each do |instance|
      @test_instance_classes[instance] =
        if instance.passed
          'table-success'
        else
          'table-danger'
        end
    end
  end

  # GET /computers/new
  def new
    @computer = @user.computers.build
  end

  # GET /computers/1/edit
  def edit
    @show_path = user_computer_path(@user, @computer)
  end

  # POST /computers
  # POST /computers.json
  def create
    @computer = Computer.new(computer_params)
    user = User.find(params[:computer][:user_id])
    unless admin? || (user && current_user && user.id == current_user.id)
      @computer.errors.add(:user_id, 'must be ' \
        'yourself unless you are an admin.')
    end

    # this if clause shouldn't be necessary, but I can't get it to work
    # otherwise
    if @computer.errors.any?
      render 'new'
    else
      respond_to do |format|
        if @computer.save
          format.html do
            redirect_to [@computer.user, @computer],
                        notice: 'Computer was successfully created.'
          end
          format.json { render :show, status: :created, location: @computer }
        else
          format.html { render :new }
          format.json do
            render json: @computer.errors, status: :unprocessable_entity
          end
        end
      end
    end
  end

  # PATCH/PUT /computers/1
  # PATCH/PUT /computers/1.json
  def update
    respond_to do |format|
      if params[:computer][:user_id]
        # only allow setting the computer's user to the logged in user unless
        # it's an admin. Skip the process if a user_id wasn't specified.
        user = User.find(params[:computer][:user_id])
        unless admin? || (user && current_user && user.id == current_user.id)
          @computer.errors.add(:user_id, 'must be yourself unless you are ' \
                                         'an admin.')
        end
      end

      if @computer.update(computer_params)
        format.html do
          redirect_to user_computer_path(computer_params[:user_id], @computer),
                      notice: 'Computer was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @computer }
      else
        format.html { render :edit }
        format.json do
          render json: @computer.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /computers/1
  # DELETE /computers/1.json
  def destroy
    @computer.destroy
    respond_to do |format|
      format.html do
        redirect_to user_computers_url(@user),
                    notice: 'Computer was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  # POST /check_computer.json
  # pretty dumb for html, but it should work, I guess
  def check_computer
    user = User.find_by(email: check_computer_params[:email])
    if user && user.authenticate(check_computer_params[:password])
      if user.computers.find_by(name: check_computer_params[:computer_name])
        # authenticated and computer belongs to user. Proceed!
        respond_to do |format|
          format.html do
            session[:user_id] = user.id
            redirect_to user_computers_path(user)
          end
          format.json do
            # send back the all clear
            render json: {
              valid: true,
              message: 'Email, password, and computer name accepted'
            }
          end
        end
      else
        # authenticated, but computer matching fails
        respond_to do |format|
          format.html do
            session[:user_id] = user.id
            redirect_to user_computers_path(user),
                        alert: "#{params[:computer_name]} is not one of your " \
                               'computers.'
          end
          format.json do
            render json: {
              valid: false,
              message: 'Email and password are valid, computer name is not.'
            }
          end
        end
      end
    else
      # we are NOT authenticated
      respond_to do |format|
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

  # Use callbacks to share common setup or constraints between actions.
  def set_computer
    @computer = @user.computers.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  # Never trust parameters from the scary internet, only allow the white list
  # through.
  def computer_params
    params.require(:computer).permit(:name, :user_id, :platform, :processor,
                                     :ram_gb)
  end

  def check_computer_params
    params.permit(:email, :password, :computer_name)
  end

  def authorize_self_or_admin
    return if admin? || @user.id == current_user.id
    redirect_to login_url, alert: 'Must be an admin or the user in ' \
      'question to do that action.'
  end
end
