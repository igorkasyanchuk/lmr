Forem::Forum.class_eval do

	def posts
		super.joins(:topic).where('forem_topics.hidden = ?', false)
	end

  def moderator?(user)
    user && user.content_manager? && !user.forum_blocked?
  end

end