class TestInstancesController < ApplicationController
  before_action :set_test_instance, only: [:show, :edit, :update, :destroy]

  # GET /test_instances
  # GET /test_instances.json
  def index
    @test_instances = TestInstance.all
  end

  # GET /test_instances/1
  # GET /test_instances/1.json
  def show
  end

  # GET /test_instances/new
  def new
    @test_instance = TestInstance.new
  end

  # GET /test_instances/1/edit
  def edit
  end

  # POST /test_instances
  # POST /test_instances.json
  def create
    @test_instance = TestInstance.new(test_instance_params)

    respond_to do |format|
      if @test_instance.save
        format.html { redirect_to @test_instance, notice: 'Test instance was successfully created.' }
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
        format.html { redirect_to @test_instance, notice: 'Test instance was successfully updated.' }
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
      format.html { redirect_to test_instances_url, notice: 'Test instance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test_instance
      @test_instance = TestInstance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_instance_params
      params.require(:test_instance).permit(:begin, :finish, :integer, :integer, :integer, :string, :string, :string, :boolean, :computer_id)
    end
end
