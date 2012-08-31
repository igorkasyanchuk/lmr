# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :forem_user

  protected
    def forem_user
      current_user
    end

    def verify_user_is_active
      redirect_to root_path, :notice => 'Тільки активні користувачі мають доступ до цієї сторінки' if current_user && current_user.blocked?
    end
end
