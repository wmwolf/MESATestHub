class TestDatum < ApplicationRecord
  belongs_to :test_instance
  validates_presence_of :name
  validates_presence_of :test_instance_id

  validate :name_is_in_test_case_names

  # name needs to be accessible as one of the specified names in the associated
  # test case
  def name_is_in_test_case_names
    instance = TestInstance.find(test_instance_id)
    test_case = instance.test_case
    unless test_case.data_names.include? name
      errors.add(:name, "isn't one of the data names for #{test_case.name}. " +
        "Available data names are: " + test_case.data_names.join(', ') + '.')
    end
  end

  def value
    case test_instance.test_case.data_type(name)
    when 'integer' then integer_val
    when 'float' then float_val
    when 'string' then string_val
    when 'boolean' then boolean_val
    end
  end

  def value=(new_val)
    case test_instance.test_case.data_type(name)
    when 'integer' then self.integer_val = new_val
    when 'float' then self.float_val = new_val
    when 'string' then self.string_val = new_val
    when 'boolean' then self.boolean_val = new_val
    # desperate debugging, delete this whole block
    else
      integer_val = new_val
      float_val = new_val
      string_val = new_val
      boolean_val = new_val
    end
  end   

end
