Forem::Forum.class_eval do
  def moderator?(user)
    user && user.content_manager? && !user.forum_blocked?
  end
end