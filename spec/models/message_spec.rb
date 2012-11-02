require 'spec_helper'

describe Message do
  
  #let(:conversation) { mock_model :conversation, :subject => 'conversation subject'}
  #
  before { @message = Message.new }

  subject { @message }

  describe '#subject' do
    subject { @message.subject }

    before do
      conversation = mock_model Conversation,
        :subject => 'conversation subject',
        :token => 'conversation token'
      @message.stub(:conversation).and_return(conversation)
    end

    it { should eq('conversation subject (conversation token)') }

  end

end
