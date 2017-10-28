class User < ApplicationRecord
  has_many :computers
  has_many :test_instances, through: :computers

  validates_uniqueness_of :email
  validates_presence_of :name

  # do checks on password to make sure it is long enough when we change, but
  # doesn't complain when it is left blank and unchanged during an edit
  validates :password, presence: { on: create }, length: { minimum: 8 },
    :if => :password_digest_changed?

  # validates :password, length: { in: 6..32 }

  has_secure_password

  def admin?
    admin
  end
end
