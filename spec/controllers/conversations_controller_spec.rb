require 'spec_helper'

describe Dashboard::ConversationsController do
  
  before :each do
    @user = FactoryGirl.create(:user)
    controller.stub!(:current_user).and_return(@user)
    controller.stub!(:authenticate_user!)
  end  

  it "should return only current user conversations" do    
    conversation = FactoryGirl.create(:conversation, :user => @user)
    conversation2 = FactoryGirl.create(:conversation, :user => FactoryGirl.build(:user, :email => 'rr@rr.com'))
    get :index
    assigns(:conversations).should eq([conversation])
  end

  it 'should create conversation with message from body' do
    Conversation.count.should eq(0)
    post :create , :conversation => {:body => 'message', :service_provider_id => '222' , :subject => 'subj'}
    Conversation.first.messages.count.should eq(1)
    Conversation.first.messages.first.body.should eq('message')
  end

  # it 'should update existing conversation with message' do    
  #   FactoryGirl.create(:conversation, :user => @user, :service_provider_id => '222')
  #   Conversation.count.should eq(1)
  #   post :create , :conversation => {:body => 'message', :service_provider_id => '222' }
  #   Conversation.count.should eq(1)
  #   Conversation.first.messages.count.should eq(2)
  #   Conversation.first.messages.last.body.should eq('message')
  # end

  it 'should show conversation messages' do
    conversation = FactoryGirl.create(:conversation, :user => @user)
    conversation2 = FactoryGirl.create(:conversation, :user => @user)
    get :show, :id => conversation.id
    assigns(:messages).should eq(conversation.messages)
    assigns(:messages).should_not eq(conversation2.messages)
  end

end