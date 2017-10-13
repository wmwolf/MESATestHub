class TestInstance < ApplicationRecord
  belongs_to :computer
  belongs_to :test_case
  has_many :test_data, dependent: :destroy
  validates_presence_of :runtime_seconds, :mesa_version, :passed

  def data(name)
    datum = test_data.where(name: name).order(updated_at: :desc).first
    case test_case.data_type(name)
    when 'integer' then datum.integer_val
    when 'float' then datum.float_val
    when 'string' then datum.string_val
    when 'boolean' then datum.boolean_val
    end
  end
end
