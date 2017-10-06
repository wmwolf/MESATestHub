class Computer < ApplicationRecord
  has_many :test_data
  has_many :test_instances
end
