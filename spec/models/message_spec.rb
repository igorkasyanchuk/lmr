require 'spec_helper'

describe Message do
  
  #let(:conversation) { mock_model :conversation, :subject => 'conversation subject'}

  subject do
    message = Message.new

    conversation = mock_model Conversation,
      :subject => 'conversation subject',
      :token => 'conversation token'

    message.stub(:conversation).and_return(conversation)
    message
  end

  its(:subject) { should eq('conversation subject (conversation token)') }
end
