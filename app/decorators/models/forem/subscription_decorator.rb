Forem::Subscription.class_eval do  

  def send_notification(post_id)
    Forem::SubscriptionMailer.topic_reply(post_id, self.subscriber.id).deliver if self.subscriber
  end

end