Forem::Admin::ForumsController.class_eval do
  def destroy
    @forum.posts.destroy_all
    @forum.topics.destroy_all
    @forum.delete
    flash[:notice] = t("forem.admin.forum.deleted")
    redirect_to admin_forums_path
  end
end