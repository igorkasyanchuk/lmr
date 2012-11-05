class ConversationMailer < ActionMailer::Base
  default from: "from@example.com"

  def message m

    @user = m.user
    @body = h.body_with_history
    mail to: m.recipients, subject: m.subject
  end

end
