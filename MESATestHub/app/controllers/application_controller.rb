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

  def self?
    @user && current_user && @user.id == current_user.id
  end

  def self_or_admin?
    admin? || self?
  end

  helper_method :current_user
  helper_method :admin?
  helper_method :self?
  helper_method :self_or_admin?

  # filters for accessing resources reserved for users or admins
  def authorize_user
    return unless current_user.nil?
    redirect_to login_url, alert: 'Must be logged in for that action.'
  end

  def authorize_admin
    return if admin?
    redirect_to login_url, alert: 'Must be an admin to do that action.'
  end

  def authorize_self_or_admin
    return if self_or_admin?
    redirect_to login_url, alert: 'Must be an admin or the owner of this '\
                                  'resource to do that action.'
  end


  # so that the menubar in every page can access the test case inventory
  def set_all_test_cases
    @all_test_cases = TestCase.where(module: :star).order(name: :asc) +
                      TestCase.where(module: :binary).order(name: :asc)
  end
end
