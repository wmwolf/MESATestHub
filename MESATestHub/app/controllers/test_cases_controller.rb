class TestCasesController < ApplicationController
  before_action :set_test_case, only: %i[show edit update destroy]

  before_action :authorize_admin, only: %i[edit update destroy new create]

  # GET /test_cases
  # GET /test_cases.json
  def index
    @mesa_versions = TestCase.versions
    this_version = params[:version] || 'latest'
    @mesa_versions.prepend('all')
    @mesa_versions.prepend('latest')
    @test_cases = TestCase.find_by_version(this_version)
    @selected = case this_version
                when 'all' then 'all'
                when 'latest' then 'latest'
                else
                  this_version
                end
    @header_text = case this_version
                   when 'all' then 'All Tests for All Versions'
                   when 'latest'
                     "Test Cases Tested on Version #{TestCase.versions.max}"
                   else
                     "Test Cases Tested on Version #{@version_number}"
                   end
    @row_classes = {}
    @test_cases.each do |t|
      @row_classes[t] =
        case t.last_version_status
        when 0 then 'table-success'
        when 1 then 'table-danger'
        else
          'table-warning'
        end
    end
  end

  # GET /test_cases/1
  # GET /test_cases/1.json
  def show
    # all test instances, sorted by upload date
    @test_instances = @test_case.test_instances.where(
      mesa_version: @test_case.last_version
    ).order(created_at: :desc).limit(20)
    @test_instance_classes = {}
    @test_instances.each do |instance|
      @test_instance_classes[instance] =
        if instance.passed
          'table-success'
        else
          'table-danger'
        end
    end

    # text and class for last version test status
    @last_version_status, @last_version_class = passing_status_and_class(
      @test_case.last_version_status
    )

    # text and class for last test status
    @last_test_status, @last_test_class = passing_status_and_class(
      @test_case.last_test_status
    )
  end

  # GET /test_cases/new
  def new
    @test_case = TestCase.new
    @modules = TestCase.modules
  end

  # GET /test_cases/1/edit
  def edit
    @modules = TestCase.modules
    @show_path = test_case_path(@test_case)
  end

  # POST /test_cases
  # POST /test_cases.json
  def create
    @test_case = TestCase.new(test_case_params)

    respond_to do |format|
      if @test_case.save
        format.html do
          redirect_to @test_case, notice: 'Test case was successfully created.'
        end
        format.json { render :show, status: :created, location: @test_case }
      else
        format.html { render :new }
        format.json do
          render json: @test_case.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /test_cases/1
  # PATCH/PUT /test_cases/1.json
  def update
    respond_to do |format|
      if @test_case.update(test_case_params)
        format.html { redirect_to @test_case, notice: 'Test case was successfully updated.' }
        format.json { render :show, status: :ok, location: @test_case }
      else
        format.html { render :edit }
        format.json { render json: @test_case.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /test_cases/1
  # DELETE /test_cases/1.json
  def destroy
    @test_case.destroy
    respond_to do |format|
      format.html { redirect_to test_cases_url, notice: 'Test case was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test_case
      @test_case = TestCase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_case_params
      params.require(:test_case).permit(:name, :module, :version_added, :description, :last_version, :last_version_status, :last_test_status, :last_tested, :datum_1_name, :datum_1_type, :datum_2_name, :datum_2_type, :datum_3_name, :datum_3_type, :datum_4_name, :datum_4_type, :datum_5_name, :datum_5_type, :datum_6_name, :datum_6_type, :datum_7_name, :datum_7_type, :datum_8_name, :datum_8_type, :datum_9_name, :datum_9_type, :datum_10_name, :datum_10_type)
    end

    # get a bootstrap text class and an appropriate string to convert integer 
    # passing status to useful web output

    def passing_status_and_class(status)
      sts = 'ERROR'
      cls = 'text-info'
      if status == 0
        sts = 'Passing'
        cls = 'text-success'
      elsif status == 1
        sts = 'Failing'
        cls = 'text-danger'
      elsif status == 2
        sts = 'Mixed'
        cls = 'text-warning'
      elsif status == 3
        sts = 'Not yet run'
        cls = 'text-warning'
      end
      return sts, cls
    end
end
