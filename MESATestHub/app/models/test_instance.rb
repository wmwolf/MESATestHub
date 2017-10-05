class TestInstance < ApplicationRecord
  belongs_to :computer
  belongs_to :test_case
  has_many :test_data
end
