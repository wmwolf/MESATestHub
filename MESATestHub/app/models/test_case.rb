class TestCase < ApplicationRecord
  has_many :test_cases
  has_many :computers, through: :test_cases
end
