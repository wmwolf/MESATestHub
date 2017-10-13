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
end
