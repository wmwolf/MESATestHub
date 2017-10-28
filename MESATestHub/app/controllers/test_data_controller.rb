class TestDataController < ApplicationController

  # this whole controller should be pretty worthless since there are no
  # routes to these resources. Yay!
  
  before_action :set_test_datum, only: [:show, :edit, :update, :destroy]

  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :authorize_self_or_admin, only: [:edit, :update, :destroy]
  before_action :authorize_user, only: [:new, :create]

  # GET /test_data
  # GET /test_data.json
  def index
    @test_data = TestDatum.all
  end

  # GET /test_data/1
  # GET /test_data/1.json
  def show
  end

  # GET /test_data/new
  def new
    @test_datum = TestDatum.new
  end

  # GET /test_data/1/edit
  def edit
  end

  # POST /test_data
  # POST /test_data.json
  def create
    @test_datum = TestDatum.new(test_datum_params)

    respond_to do |format|
      if @test_datum.save
        format.html { redirect_to @test_datum, notice: 'Test datum was successfully created.' }
        format.json { render :show, status: :created, location: @test_datum }
      else
        format.html { render :new }
        format.json { render json: @test_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /test_data/1
  # PATCH/PUT /test_data/1.json
  def update
    respond_to do |format|
      if @test_datum.update(test_datum_params)
        format.html { redirect_to @test_datum, notice: 'Test datum was successfully updated.' }
        format.json { render :show, status: :ok, location: @test_datum }
      else
        format.html { render :edit }
        format.json { render json: @test_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /test_data/1
  # DELETE /test_data/1.json
  def destroy
    @test_datum.destroy
    respond_to do |format|
      format.html { redirect_to test_data_url, notice: 'Test datum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test_datum
      @test_datum = TestDatum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_datum_params
      params.require(:test_datum).permit(:name, :string_val, :float_val, :integer_val, :boolean_val, :instance)
    end

    def set_user
      @user ||= @test_datum.test_instance.computer.user
    end

    def authorize_self_or_admin
      unless admin? or @user.id == current_user.id
        redirect_to login_url, alert: "Must be an admin or the user in " +
        "question to do that action."
      end
    end
end
