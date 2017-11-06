class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_all_test_cases

  private

  # getting current user and admin status
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def admin?
    return false unless current_user
    current_user.admin?
  end
  helper_method :current_user
  helper_method :admin?

  # filters for accessing resources reserved for users or admins
  def authorize_user
    redirect_to login_url, alert: "Must be logged in for that action." if current_user.nil?
  end

  def authorize_admin
    redirect_to login_url, alert: "Must be an admin to do that action." unless admin?
  end

  # so that the menubar in every page can access the test case inventory
  def set_all_test_cases
    @all_test_cases = TestCase.where(module: :star).order(name: :asc) +
                      TestCase.where(module: :binary).order(name: :asc)
  end

end
