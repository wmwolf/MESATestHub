class TestInstancesController < ApplicationController
  before_action :get_test_case
  before_action :set_test_instance, only: [:show, :edit, :update, :destroy]

  # GET /test_instances
  # GET /test_instances.json
  def index
    @test_instances = @test_case.test_instances
  end

  # GET /test_instances/1
  # GET /test_instances/1.json
  def show
    @passage_class = @test_instance.passed ? 'text-success' : 'text-danger'
    @passage_status = @test_instance.passed ? 'PASS' : 'FAIL'

  end

  # GET /test_instances/new
  def new
    @test_instance = @test_case.test_instances.build
  end

  # GET /test_instances/1/edit
  def edit
  end

  # POST /test_instances
  # POST /test_instances.json
  def create
    @test_instance = @test_case.test_instances.build(test_instance_params)
    # TestInstance.new(test_instance_params)

    respond_to do |format|
      if @test_instance.save
        format.html { redirect_to test_case_test_instances_url(@test_case), notice: 'Test instance was successfully created.' }
        format.json { render :show, status: :created, location: @test_instance }
      else
        format.html { render :new }
        format.json { render json: @test_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /test_instances/1
  # PATCH/PUT /test_instances/1.json
  def update
    respond_to do |format|
      if @test_instance.update(test_instance_params)
        format.html { redirect_to test_case_test_instances_url(@test_case), notice: 'Test instance was successfully updated.' }
        format.json { render :show, status: :ok, location: @test_instance }
      else
        format.html { render :edit }
        format.json { render json: @test_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /test_instances/1
  # DELETE /test_instances/1.json
  def destroy
    @test_instance.destroy
    respond_to do |format|
      format.html { redirect_to test_case_test_instances_url(@test_instance.test_case), notice: 'Test instance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test_instance
      @test_instance = @test_case.test_instances.find(params[:id])
      # @test_instance = TestInstance.find(params[:id])
    end

    def get_test_case
      @test_case = TestCase.find(params[:test_case_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_instance_params
      params.require(:test_instance).permit(:begin, :finish, :runtime_seconds, 
        :mesa_version, :omp_num_threads, :compiler, :compiler_version,
        :platform_version, :passed, :computer_id, :test_case_id)
    end
end
