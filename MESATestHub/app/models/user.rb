class User < ApplicationRecord
  has_many :computers
  has_many :test_instances, through: :computers

  validates_uniqueness_of :email
  validates_presence_of :name

  has_secure_password

  def admin?
    admin
  end
end
