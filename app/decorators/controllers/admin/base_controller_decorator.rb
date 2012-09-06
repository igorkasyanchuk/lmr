Forem::Admin::BaseController.class_eval do
  def authenticate_forem_admin
    unless (forem_user.admin? || forem_user.content_manager?) && !forem_user.forum_blocked?
      flash.alert = t("forem.errors.access_denied")
      redirect_to forums_path #TODO: not positive where to redirect here
    end
  end
end