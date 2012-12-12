class ConversationMailer < ActionMailer::Base
  default from: "from@example.com"

  def new_message m
    @user = m.user
    @body = m.body_with_history
    mail(to: m.recipients, subject: m.subject, bcc: m.cc_addresses)
  end

end
