Forem::ApplicationController.class_eval do
  def forem_admin?
    forem_user && forem_user.forem_admin? && forem_user.admin?
  end
end