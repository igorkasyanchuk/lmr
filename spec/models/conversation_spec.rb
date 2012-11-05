require 'spec_helper'

describe Conversation do

  before { @conversation =  Conversation.new subject: 'con subject', token: '123456789' }

  subject(:conversation) { @conversation }
  
  describe '#reply_with_form' do

    before do
      @conversation.stub(:user).and_return(mock_model User, email: 'consumer@mail.local')
      @conversation.stub(:service_provider).and_return(mock_model ServiceProvider, email: 'provider@mail.local')
    end

    it "creates message " do
      conversation.messages.should_receive(:create).with(
        :body => 'response',
        :recipients => %w[consumer@mail.local provider@mail.local]
      ).and_return(mock :message, :mail! => true)

      conversation.reply_with_form :body => 'response'
    end

  end

  describe "#history " do

    before do
      @conversation.stub(:messages).and_return([
        mock_model(Message, body: 'Message 1'),
        mock_model(Message, body: 'Message 2'),
        mock_model(Message, body: 'Message 3')
      ])
    end

    subject { @conversation.history }
    
    it 'joins messages with horizontal divider' do
      should eq('Message 1<hr>Message 2<hr>Message 3')
    end
  end
  
end
