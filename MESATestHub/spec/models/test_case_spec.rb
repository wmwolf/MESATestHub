require 'rails_helper'
require 'date'

# WARNING: these tests probably need to be mocked/doubled, as they rely on
# TestInstance working properly. Since it's mostly just accessing database
# columns, it should be fine, but it still feels icky.

RSpec.describe TestCase, type: :model do

  before :all do
    @old = 9795
    @new = 10000
    @early = DateTime.parse("October 28, 1987")
    @late = DateTime.parse("December 25, 2017")
  end

  before :each do
    @test = TestCase.create(name: 'my_test_case')
  end

  # the block below was for an older implementation that proved unreliable. 
  # ideally these should still work, but something about how rspec works
  # won't allow faking out associations, and making isolated tests is 
  # thus quite difficult. Maybe later.

  # describe 'adding a test instance' do
  #   before :each do
  #     @instances = []
  #     @instance_1 = TestInstance.create(mesa_version: @new, passed: true)
  #     @instance_2 = TestInstance.create(mesa_version: @new, passed: false)
  #     @instance_3 = TestInstance.create(mesa_version: @old, passed: true)
  #     @instance_4 = TestInstance.create(mesa_version: @old, passed: false)
  #   end

  #   it 'updates the last version when the first test is uploaded' do
  #     # @test.test_instances << @instance_1
  #     @instances << @instance_1
  #     allow(@test).to_receive(:test_instances).and_return @instances

  #     expect(@test.last_version).to be(@instance_1.mesa_version)
  #   end

  #   it "doesn't update the version when an older test is uploaded" do
  #     # allow(@instance_1).to receive(:mesa_version).and_return @new
  #     # allow(@instance_1).to receive(:passed).and_return true

  #     # allow(@instance_2).to receive(:mesa_version).and_return @old
  #     # allow(@instance_2).to receive(:passed).and_return true

  #     @test.test_instances << @instance_1
  #     @test.test_instances << @instance_3

  #     expect(@test.last_version).to not_be(@instance_1.mesa_version)
  #   end

  #   it "does update the version when a newer test is uploaded" do
  #     # allow(@instance_1).to receive(:mesa_version).and_return @old
  #     # allow(@instance_1).to receive(:passed).and_return true

  #     # allow(@instance_2).to receive(:mesa_version).and_return @new
  #     # allow(@instance_2).to receive(:passed).and_return true

  #     @test.test_instances << @instance_3
  #     @test.test_instances << @instance_1

  #     expect(@test.last_version).to be(@instance_1.mesa_version)
  #   end

  #   it 'updates the last version status to passing when first test passes' do
  #     allow(@instance_1).to receive(:mesa_version).and_return @new
  #     allow(@instance_1).to receive(:passed).and_return true

  #     @test.test_instances.append(@instance_1)

  #     expect(@test.last_version_status).to be(0)
  #   end

  #   it 'updates the last version status to failing when first test fails' do
  #     allow(@instance_1).to receive(:mesa_version).and_return @new
  #     allow(@instance_1).to receive(:passed).and_return false

  #     @test.test_instances.append(@instance_1)

  #     expect(@test.last_version_status).to be(1)
  #   end

  #   it 'updates the last version status to mixed when two tests differ (passing first)' do
  #     allow(@instance_1).to receive(:mesa_version).and_return @new
  #     allow(@instance_1).to receive(:passed).and_return true

  #     allow(@instance_2).to receive(:mesa_version).and_return @new
  #     allow(@instance_2).to receive(:passed).and_return false

  #     @test.test_instances.append(@instance_1)
  #     @test.test_instances.append(@instance_2)

  #     expect(@test.last_version_status).to be(2)
  #   end

  #   it 'updates the last version status to mixed when two tests differ (failing first)' do
  #     allow(@instance_1).to receive(:mesa_version).and_return @new
  #     allow(@instance_1).to receive(:passed).and_return true

  #     allow(@instance_2).to receive(:mesa_version).and_return @new
  #     allow(@instance_2).to receive(:passed).and_return false

  #     @test.test_instances.append(@instance_2)
  #     @test.test_instances.append(@instance_1)

  #     expect(@test.last_version_status).to be(2)
  #   end

  #   it 'keeps the last version status passing when two tests pass' do
  #     allow(@instance_1).to receive(:mesa_version).and_return @new
  #     allow(@instance_1).to receive(:passed).and_return true

  #     allow(@instance_2).to receive(:mesa_version).and_return @new
  #     allow(@instance_2).to receive(:passed).and_return true

  #     @test.test_instances.append(@instance_1)
  #     @test.test_instances.append(@instance_2)

  #     expect(@test.last_version_status).to be(0)
  #   end

  #   it 'keeps the last version status failing when two tests fail' do
  #     allow(@instance_1).to receive(:mesa_version).and_return @new
  #     allow(@instance_1).to receive(:passed).and_return false

  #     allow(@instance_2).to receive(:mesa_version).and_return @new
  #     allow(@instance_2).to receive(:passed).and_return false

  #     @test.test_instances.append(@instance_1)
  #     @test.test_instances.append(@instance_2)

  #     expect(@test.last_version_status).to be(1)
  #   end


  #   it "doesn't change last version status after an older version is tested" do
  #     allow(@instance_1).to receive(:mesa_version).and_return @new
  #     allow(@instance_1).to receive(:passed).and_return true

  #     allow(@instance_2).to receive(:mesa_version).and_return @old
  #     allow(@instance_2).to receive(:passed).and_return false

  #     @test.test_instances.append(@instance_1)
  #     @test.test_instances.append(@instance_2)

  #     expect(@test.last_version_status).to be 0
  #   end      

  #   it "does change last version status after an older version is tested" do
  #     allow(@instance_1).to receive(:mesa_version).and_return @old
  #     allow(@instance_1).to receive(:passed).and_return true

  #     allow(@instance_2).to receive(:mesa_version).and_return @new
  #     allow(@instance_2).to receive(:passed).and_return false

  #     @test.test_instances.append(@instance_1)
  #     @test.test_instances.append(@instance_2)

  #     expect(@test.last_version_status).to be 1
  #   end      

  #   it 'updates the last test result after the first test' do
  #     allow(@instance_1).to receive(:mesa_version).and_return @new
  #     allow(@instance_1).to receive(:passed).and_return true

  #     @test.test_instances.append(@instance_1)

  #     expect(@test.last_test_status).to be(0)
  #   end

  #   it 'updates the last test result after the second test' do
  #     allow(@instance_1).to receive(:mesa_version).and_return @new
  #     allow(@instance_1).to receive(:passed).and_return true

  #     allow(@instance_2).to receive(:mesa_version).and_return @new
  #     allow(@instance_2).to receive(:passed).and_return false

  #     @test.test_instances.append(@instance_1)
  #     @test.test_instances.append(@instance_2)

  #     expect(@test.last_test_status).to be(1)
  #   end

  #   it 'updates the last tested date when the first test is added' do
  #     allow(@instance_1).to receive(:created_at).and_return(@early)

  #     @test.test_instances << @instance_1

  #     expect(@test.last_tested).to eq @early
  #   end


  #   it 'updates the last tested date when the second, newer test is added' do
  #     allow(@instance_1).to receive(:created_at).and_return(@early)
  #     allow(@instance_2).to receive(:created_at).and_return(@late)

  #     @test.test_instances << @instance_1
  #     @test.test_instances << @instance_2

  #     expect(@test.last_tested).to eq @late
  #   end

  #   it "doesn't update the last tested date a second, older test is added" do
  #     allow(@instance_1).to receive(:created_at).and_return(@early)
  #     allow(@instance_2).to receive(:created_at).and_return(@late)

  #     @test.test_instances << @instance_2
  #     @test.test_instances << @instance_1

  #     expect(@test.last_tested).to eq @late
  #   end
  # end

  describe 'specifying custom data' do
    before :each do
      @test.datum_1_name = 'num_steps'
      @test.datum_1_type = 'integer'
      @test.datum_2_name = 'num_retries'
      @test.datum_2_type = 'integer'
      @test.datum_4_name = 'num_backups'
      @test.datum_4_type = 'integer'
      @test.datum_5_name = 'log_L_final'
      @test.datum_5_type = 'float'
    end

    it 'finds the used data names' do
      expect(@test.data_names).to eq(['num_steps', 'num_retries',
        'num_backups', 'log_L_final'])
    end

    it 'finds the data type of a data name' do
      expect(@test.data_type('num_steps')).to eq 'integer'
    end
  end
end
