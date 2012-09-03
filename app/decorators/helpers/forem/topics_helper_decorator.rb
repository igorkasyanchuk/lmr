Forem::TopicsHelper.class_eval do
  def link_to_latest_post(topic)
    post = relevant_posts(topic).last
    text = "#{time_ago_in_words(post.created_at)} #{t("ago_by")} #{post.user.full_name}"
    link_to text, forem.forum_topic_path(post.topic.forum, post.topic, :anchor => "post-#{post.id}")
  end

  def new_since_last_view_text(topic)
    if forem_user
      topic_view = topic.view_for(forem_user)
      forum_view = topic.forum.view_for(forem_user)

      if forum_view
        if topic_view.nil? && topic.created_at > forum_view.past_viewed_at
          content_tag :super, t('forum.new_messages')
        end
      end
    end
  end

end