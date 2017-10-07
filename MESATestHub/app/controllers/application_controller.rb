class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_all_test_cases

  # so that the menubar in every page can access the test case inventory
  def set_all_test_cases
    @all_test_cases = TestCase.order(name: :desc)
  end
end
