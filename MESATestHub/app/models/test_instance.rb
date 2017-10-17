class TestInstance < ApplicationRecord
  belongs_to :computer
  belongs_to :test_case
  has_many :test_data, dependent: :destroy
  validates_presence_of :runtime_seconds, :mesa_version, :passed

  def data(name)
    test_data.where(name: name).order(updated_at: :desc).first.value
  end

  def set_data(name, new_val)
    test_data.where(name: name).order(updated_at: :desc).first.value = new_value
  end

  # make test_data easier to access as if they were attributes
  def method_missing(method_name, *args, &block)
    if test_case.data_names.include? method_name.to_s
      data(method_name.to_s)
    elsif test_case.data_names.include? method_name.to_s.chomp('=') and args.length > 0
      set_data(method_name.to_s.chomp('='), args[0])
    else
      super(method_name, *args, &block)
    end
  end
    
end
