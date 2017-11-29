class Computer < ApplicationRecord
  has_many :test_data, through: :test_instances
  has_many :test_instances, dependent: :destroy
  belongs_to :user
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :user_id
  validates_presence_of :platform

  def self.platforms
    %w[macOS linux]
  end

  validates_inclusion_of :platform, in: %w[macOS linux]

  def user_name
    user.name
  end

  def email
    user.email
  end

  def validate_user(creator)
    return if creator.admin? || (creator.id == user_id)
    errors.add(:user, 'must be current user unless you are an admin.')
  end
end
