require 'spec_helper'

describe ForumController do
  before :each do
    admin = FactoryGirl.build(:admin_user)
    controller.stub!(:current_user).and_return(admin)
  end

  it "should return spam users" do    
    user = FactoryGirl.build(:user)
    spam_user = FactoryGirl.build(:spam_user)
    get :index
    assigns(:users).should eq([spam_user])
  end

  it 'should toggle approve of user' do
    user = FactoryGirl.build(:user)
    spam_user = FactoryGirl.build(:spam_user)
    get :index
    assigns(:users).should eq([spam_user])    
    xhr :post, :toggle_approve, :id => user.id
    get :index
    assigns(:users).should eq([user, spam_user])
  end

  it 'should search users' do    
    get :autocomplete, :term => 'su'
    response.should be_success
  end

end