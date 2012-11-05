require 'spec_helper'

describe Message do
  
  #let(:conversation) { mock_model :conversation, :subject => 'conversation subject'}
  #
  before do
    @message = Message.new
    @conversation = Conversation.new :subject => 'conversation subject', :token => 'conversation token'
    @message.stub(:conversation).and_return(@conversation)
  end

  subject(:message) { @message }

  describe '#subject' do
    subject { @message.subject }

    it { should eq('conversation subject (conversation token)') }

  end

  describe "#mail!" do
    it 'sends messageby e-mail' do
      mail_mock = mock :mail
      ConversationMailer.should_receive(:new_message).with(message).and_return(mail_mock)
      mail_mock.should_receive(:deliver)

      message.mail!
    end
  end

  describe "#body_with_history" do

    before do
      @message.body = 'Message to service provider'
      @message.stub(:history).and_return('Previous mailing on this subject')
    end

    subject { @message.body_with_history }

    it { should eq 'Message to service provider<hr>Previous mailing on this subject' }

  end

  describe "#history" do
    subject { @message.history }

    before do
      @conversation.stub(:history).and_return('conversation history')
    end

    
    it "gets history from conversation" do
      should eq 'conversation history'
    end

  end

  describe '#user' do
    subject { @message.user }

    before { @conversation.stub(:user).and_return(:conversation_user) }

    it { should eq :conversation_user }

  end

end
