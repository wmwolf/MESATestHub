class TestCase < ApplicationRecord
  has_many :test_instances, dependent: :destroy
  has_many :computers, through: :test_instances

  validates_presence_of :name
  validates_uniqueness_of :name

  validates_inclusion_of :datum_1_type, in: ['integer', 'float', 'string', 'boolean'], allow_blank: true
  validates_inclusion_of :datum_2_type, in: ['integer', 'float', 'string', 'boolean'], allow_blank: true
  validates_inclusion_of :datum_3_type, in: ['integer', 'float', 'string', 'boolean'], allow_blank: true
  validates_inclusion_of :datum_4_type, in: ['integer', 'float', 'string', 'boolean'], allow_blank: true
  validates_inclusion_of :datum_5_type, in: ['integer', 'float', 'string', 'boolean'], allow_blank: true
  validates_inclusion_of :datum_6_type, in: ['integer', 'float', 'string', 'boolean'], allow_blank: true
  validates_inclusion_of :datum_7_type, in: ['integer', 'float', 'string', 'boolean'], allow_blank: true
  validates_inclusion_of :datum_8_type, in: ['integer', 'float', 'string', 'boolean'], allow_blank: true
  validates_inclusion_of :datum_9_type, in: ['integer', 'float', 'string', 'boolean'], allow_blank: true
  validates_inclusion_of :datum_10_type, in: ['integer', 'float', 'string', 'boolean'], allow_blank: true


  def TestCase.modules
    ['star', 'binary']
  end
  validates_inclusion_of :module, in: TestCase.modules, allow_blank: true

  # this is ugly and hard-codey, but what're ya gonna do?
  def data_names
    [datum_1_name, datum_2_name, datum_3_name, datum_4_name,
     datum_5_name, datum_6_name, datum_7_name, datum_8_name, datum_9_name, 
     datum_10_name].reject { |name| name.nil? or name.strip.empty? }
  end

  def data_types
    [datum_1_type, datum_2_type, datum_3_type, datum_4_type,
     datum_5_type, datum_6_type, datum_7_type, datum_8_type, datum_9_type, 
     datum_10_type].reject { |type| type.nil? or type.strip.empty? }
  end

  # assumes the user put in matching data names and types (i.e. datum_1_name
  # ALWAYS has a corresponding datum_1_type and there are no orphans). This
  # should be handled by a validation
  def data_type(data_name)
    return nil unless data_names.include? data_name
    return Hash[data_names.zip data_types][data_name]
  end

  def last_tested
    test_instances.maximum(:created_at)
  end

  alias :last_tested_date :last_tested

  def last_test_status
    return 3 if test_instances.empty?
    test_instances.where(created_at: last_tested_date).first.passed ? 0 : 1
  end

  def last_version
    test_instances.maximum(:mesa_version)
  end

  def last_version_status
    return 3 if test_instances.empty?
    failing = test_instances.where(mesa_version: last_version, passed: false)
    passing = test_instances.where(mesa_version: last_version, passed: true)
    if failing.count > 0
      # both counts > 1, mixed (2). Only failing > 1, failing (1)
      passing.count > 0 ? 2 : 1
    else
      # passing status
      return 0
    end
  end
end
