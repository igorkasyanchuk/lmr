Forem::ApplicationController.class_eval do
  def forem_admin?
    forem_user.admin? || forem_user.content_manager?
  end
end