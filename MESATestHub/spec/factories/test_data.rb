FactoryGirl.define do
  factory :test_datum do
    name "MyString"
    string_val "MyString"
    float_val 1.5
    integer_val 1
    boolean_val false
    instance ""
  end
end
