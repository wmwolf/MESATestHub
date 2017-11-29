class TestInstance < ApplicationRecord
  @@success_types =  {
    'run_test_string' => 'Test String',
    'run_checksum' => 'Run Checksum',
    'photo_checksum' => 'Photo Checksum'
  }

  @@failure_types = {
    'run_test_string' => 'Test String',
    'run_checksum' => 'Run Checksum',
    'run_diff' => 'Run Diff',
    'photo_file' => 'Missing Photo',
    'photo_checksum' => 'Photo Checkusm',
    'photo_diff' => 'Photo Diff',
    'compliation' => 'Compilation'
  }

  @@compilers = %w[gfortran ifort SDK]

  belongs_to :computer
  belongs_to :test_case
  has_many :test_data, dependent: :destroy
  validates_presence_of :runtime_seconds, :mesa_version, :computer_id,
                        :test_case_id
  # validates_inclusion_of :passed, in: [true, false]
  validates_inclusion_of :success_type, in: @@success_types.keys,
                                        allow_blank: true
  validates_inclusion_of :failure_type, in: @@failure_types.keys,
                                        allow_blank: true
  validates_inclusion_of :compiler, in: @@compilers, allow_blank: true

  def self.success_types
    @@success_types
  end

  def self.failure_types
    @@failure_types
  end

  def self.compilers
    @@compilers
  end

  # descending list of all mesa versions
  def self.versions
    distinct.pluck(:mesa_version).sort.reverse
  end

  def data(name)
    test_data.where(name: name).order(updated_at: :desc).first.value
  end

  def set_data(name, new_val)
    test_data.where(name: name).order(updated_at: :desc).first.value = new_val
  end

  def set_computer_name(user, new_computer_name)
    new_computer = user.computers.where(name: new_computer_name).first
    if new_computer.nil?
      errors.add :computer_id, 'Could not find computer with name ' \
        "\"#{new_computer_name}\"."
    else
      self.computer = new_computer
    end
  end

  def set_test_case_name(new_test_case_name, mod)
    new_test_case = TestCase.where(name: new_test_case_name).first
    if new_test_case.nil?
      # no test case found, so just make one up
      # this test case will have NO EXTRA DATA ASSOCIATED WITH IT
      # at time of this edit (November 22, 2017), the data features is not in
      # use, but this may need to be revisited
      new_test_case = TestCase.create(
        name: new_test_case_name, version_added: mesa_version, module: mod
      )
      # old behavior: scuttle the saving process
      # errors.add :test_case_id,
      #            'Could not find test case with name "' + new_test_case_name +
      #            '".'
    end
    self.test_case = new_test_case
  end

  # full text for passage status
  def passage_status
    if passed
      if success_type
        "PASS: #{TestInstance.success_types[success_type]}"
      else
        "PASS"
      end
    else
      if failure_type
        "FAIL: #{TestInstance.failure_types[failure_type]}"
      else
        "FAIL"
      end
    end
  end


  # make test_data easier to access as if they were attributes
  def method_missing(method_name, *args, &block)
    if test_case.data_names.include? method_name.to_s
      data(method_name.to_s)
    elsif test_case.data_names.include? method_name.to_s.chomp('=') and args.length > 0
      set_data(method_name.to_s.chomp('='), args[0])
    else
      super(method_name, *args, &block)
    end
  end
    
end
