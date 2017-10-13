class Computer < ApplicationRecord
  has_many :test_data, through: :test_instances
  has_many :test_instances, dependent: :destroy
  validates_presence_of :name
  validates_uniqueness_of :name
end
