class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :require_login

  def not_authenticated
    flash[:warning] = t('message.require_login')
    redirect_to login_path
  end
end
