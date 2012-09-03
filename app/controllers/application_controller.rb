# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :forem_user, :my_dashboard_path

  protected
    def forem_user
      current_user
    end

    def verify_user_is_active
      redirect_to root_path, :notice => 'Тільки активні користувачі мають доступ до цієї сторінки' if current_user && current_user.blocked?
    end

    def after_sign_in_path_for(resource_or_scope)
      '/log'
    end

    def my_dashboard_path
      if current_user.admin? || current_user.content_manager?
        '/admin'
      else
        '/dashboard'
      end
    end

end
