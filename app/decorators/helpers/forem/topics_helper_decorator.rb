Forem::TopicsHelper.class_eval do
  def link_to_latest_post(topic)
    post = relevant_posts(topic).last
    text = "#{time_ago_in_words(post.created_at)} #{t("ago_by")}</br> #{post.user.try(:forum_name)}".html_safe
    p = post_page(topic.posts.index(post)) == 1 ? '1' : post_page(topic.posts.index(post))
    link_to text, forem.forum_topic_path(post.topic.forum, post.topic, page: p, anchor: "post-#{post.id}")
  end
end