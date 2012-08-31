Forem::ApplicationController.class_eval do
  def forem_admin?
    forem_user && (forem_user.admin? || forem_user.has_role?("content_manager")) && !forem_user.forum_blocked?
  end
end