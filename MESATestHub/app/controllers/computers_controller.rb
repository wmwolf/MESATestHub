class ComputersController < ApplicationController
  before_action :set_computer, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:index, :show, :new, :create]
  before_action :authorize_self_or_admin, only: [:edit, :update, :destroy]

  skip_before_action :verify_authenticity_token, only: [:check_computer]

  # GET /computers
  # GET /computers.json
  def index
    @computers = current_user.computers
  end

  # GET /computers/1
  # GET /computers/1.json
  def show
  end

  # GET /computers/new
  def new
    @computer = current_user.computers.build
  end

  # GET /computers/1/edit
  def edit
  end

  # POST /computers
  # POST /computers.json
  def create
    # only allow admins or the computer's user to create the computer
    # i.e., oner user cannot make a computer for another user
    @computer = Computer.new(computer_params)
    @computer.validate_user(current_user)
    # this if clause shouldn't be necessary, but I can't get it to work
    # otherwise
    if @computer.errors.any?
      render 'new'
    else
      respond_to do |format|
        if @computer.save
          format.html { redirect_to @computer,
            notice: 'Computer was successfully created.' }
          format.json { render :show, status: :created, location: @computer }
        else
          format.html { render :new }
          format.json { render json: @computer.errors,
            status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /computers/1
  # PATCH/PUT /computers/1.json
  def update
    respond_to do |format|
      if computer_params[:user_id]
        # only allow setting the computer's user to the logged in user unless
        # it's an admin. Skip the process if a user_id wasn't specified.
        unless admin? or current_user.id == computer_params[:user_id]
          @computer.errors.add(:user_id, "May only associate computers to "+
            "yourself unless you are an admin.")
        end
      end

      if @computer.update(computer_params)
        format.html { redirect_to @computer,
          notice: 'Computer was successfully updated.' }
        format.json { render :show, status: :ok, location: @computer }
      else
        format.html { render :edit }
        format.json { render json: @computer.errors,
          status: :unprocessable_entity }
      end
    end
  end

  # DELETE /computers/1
  # DELETE /computers/1.json
  def destroy
    @computer.destroy
    respond_to do |format|
      format.html { redirect_to computers_url,
        notice: 'Computer was successfully destroyed.' }
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
            redirect_to computers_path
          end
          format.json do
            # send back the all clear
            render json: { valid: true,
              message: "Email, password, and computer name accepted" }
          end
        end
      else
        # authenticated, but computer matching fails
        respond_to do |format|
          format.html do
            session[:user_id] = user.id
            redirect_to computer_path, alert: "#{params[:computer_name]} " +
              "is not one of your computers."
          end
          format.json do
            render json: { valid: false,
              message: "Email and password are valid, computer name is not."}
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
      @computer = Computer.find(params[:id])
    end

    def set_user
      @user = @computer.user
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
      unless admin? or @user.id == current_user.id
        redirect_to login_url, alert: "Must be an admin or the user in " +
        "question to do that action."
      end
    end

end
