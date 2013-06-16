# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  private
  def check_admin
    unless logged_in? && current_user.admin?
      error_message
    end
  end
  def not_authenticated
    unless logged_in?
      error_message
    end
  end
  def error_message(msg='Доступ запрещен')
    @msg=msg
    render 'layouts/error'
  end
end
