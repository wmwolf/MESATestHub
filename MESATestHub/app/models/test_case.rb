class TestCase < ApplicationRecord
  has_many :test_instances
  has_many :computers, through: :test_instances
end
