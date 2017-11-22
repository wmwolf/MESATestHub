class TestInstancesController < ApplicationController
  before_action :set_test_case, except: [:submit]
  before_action :set_test_instance, only: %i[show edit update destroy]
  # set_user depends on @test_instance being set, so it can only be used
  # where set_test_instance has already been called.
  before_action :set_user, only: %i[edit update destroy]
  skip_before_action :verify_authenticity_token, only: [:submit]

  # note that submit does some fancy footwork on the fly
  before_action :authorize_self_or_admin, only: %i[edit update destroy]
  before_action :authorize_user, only: %i[new create]

  # GET /test_instances
  # GET /test_instances.json
  def index
    @test_instances = @test_case.test_instances.order(mesa_version: :desc,
                                                      created_at: :desc)
  end

  # GET /test_instances/1
  # GET /test_instances/1.json
  def show
    @passage_class = @test_instance.passed ? 'text-success' : 'text-danger'
    @passage_status = @test_instance.passage_status
    @self_or_admin = admin? || (@user && @user.id == current_user.id)
  end

  # GET /test_instances/new
  def new
    @test_instance = @test_case.test_instances.build
  end

  # GET /test_instances/1/edit
  def edit
    @show_path = test_case_test_instance_path(@test_case, @test_instance)
  end

  # POST /test_instances/submit
  # POST /test_instances/submit.json
  def submit
    # we are authenticated from params or session
    if submission_authenticated?
      @test_instance = submission_instance
      submission_save
    # params authentication failed. Redirect (html) or report failure (JSON)
    else
      submission_fail_authentication
    end
  end

  # POST /test_instances
  # POST /test_instances.json
  def create
    @test_instance = @test_case.test_instances.build(test_instance_params)
    # TestInstance.new(test_instance_params)

    respond_to do |format|
      if @test_instance.save
        format.html do
          redirect_to test_case_test_instances_url(@test_case),
                      notice: 'Test instance was successfully created.'
        end
        format.json { render :show, status: :created, location: @test_instance }
      else
        format.html { render :new }
        format.json do
          render json: @test_instance.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /test_instances/1
  # PATCH/PUT /test_instances/1.json
  def update
    respond_to do |format|
      if @test_instance.update(test_instance_params)
        format.html do
          redirect_to test_case_test_instances_url(@test_case),
                      notice: 'Test instance was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @test_instance }
      else
        format.html { render :edit }
        format.json do
          render json: @test_instance.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /test_instances/1
  # DELETE /test_instances/1.json
  def destroy
    @test_instance.destroy
    respond_to do |format|
      format.html do
        redirect_to test_case_test_instances_url(@test_instance.test_case),
                    notice: 'Test instance was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # the following methods are helper (read: shorter) methods used as part of
  # the "submit" controller action meant to streamline that definition
  def submission_authenticated?
    # If logged on to website, we're good
    @user = current_user
    authenticated = !@user.nil?

    # If not logged on, or submitting via JSON post (likely), check params
    unless authenticated
      @user = User.find_by(email: params[:email])
      authenticated = @user && @user.authenticate(params[:password])
    end

    authenticated
  end

  def submission_instance
    instance = TestInstance.new(submission_instance_params)
    # find the appropriate test_case and computer
    instance.set_test_case_name(params[:test_case])
    instance.set_computer_name(@user, params[:computer])
    instance
  end

  def submission_fail_authenticate
    respond_to do |format|
      format.html do
        redirect_to login_url,
                    alert: 'Must be signed in to submit a test instance.'
      end
      format.json do
        render json: { error: 'Invalid e-mail or password.' },
               status: :unprocessable_entity
      end
    end
  end

  def submission_set_data
    data_params.each do |data_name, data_val|
      datum = @test_instance.test_data.build(name: data_name)
      datum.value = data_val
      datum.save!
    end
  end

  def submission_save
    respond_to do |format|
      if @test_instance.save
        submission_successful_save(format)
      else
        submission_fail_save(format)
      end
    end
  end

  def submission_fail_save(format)
    format.html { render :new }
    format.json do
      render json: @test_instance.errors,
             status: :unprocessable_entity
    end
  end

  def submission_successful_save(format)
    @test_case = @test_instance.test_case
    submission_set_data
    format.html do
      redirect_to test_case_test_instances_url(@test_case),
                  notice: 'Test instance was successfully created.'
    end
    format.json do
      render :show, status: :created, location:
        test_case_test_instance_path(@test_case, @test_instance)
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_test_instance
    @test_instance = @test_case.test_instances.find(params[:id])
    # @test_instance = TestInstance.find(params[:id])
  end

  def set_test_case
    @test_case = TestCase.find(params[:test_case_id])
  end

  def set_user
    @user = @test_instance.computer.user
  end

  # Never trust parameters from the scary internet, only allow the white list
  # through.

  # these are params used in submission that are NOT used for creating the
  # instance itself. :test_case and :computer are used for discerning foreign
  # keys, but do not go into the actual build command. The data names are
  # used for creating asscoicated test_data objects.
  def submission_bonus_keys
    [:email, :password, :test_case, :computer,
     *@test_case.data_names.map(&:to_sym)]
  end

  def instance_keys
    %i[runtime_seconds mesa_version omp_num_threads compiler compiler_version
       platform_version passed failure_type success_type]
  end

  # allowed params for using the submit controller action
  def submission_params
    params.permit(*[instance_keys, submission_bonus_keys].flatten)
  end

  # once we're in submit, these are the params used to build the new instance
  def submission_instance_params
    new_hash = {}
    instance_keys.each do |key|
      new_hash[key] = params[key] if params[key]
    end
    new_hash
  end

  def data_params
    submission_params.select do |key, _value|
      @test_case.data_names.include? key.to_s
    end
  end

  # for traditional update/create process
  def test_instance_params
    params.require(:test_instance).permit(
      :runtime_seconds, :mesa_version, :omp_num_threads, :compiler,
      :compiler_version, :platform_version, :passed, :computer_id,
      :test_case_id, :success_type, :failure_type
    )
  end
end
