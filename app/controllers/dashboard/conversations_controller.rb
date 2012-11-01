# encoding: utf-8
class Dashboard::ConversationsController < Dashboard::DashboardController

  before_filter :add_service_providers, :only => [:new, :create]

  def index
    @conversations = current_user.conversations
  end

  def new
    @conversation = Conversation.new    
  end

  def create
    @conversation = Conversation.new(params[:conversation])
    if current_user.conversations << @conversation
      redirect_to dashboard_conversation_url(@conversation)
    else
      render :new
    end
  end

  def show
    @conversation = Conversation.find(params[:id])
    @messages = @conversation.messages
  end

  def message
    params[:message][:from] = current_user.full_name
    @message = Message.new(params[:message])
    if @message.save
      redirect_to dashboard_conversation_url(@message.conversation)
    else
      conversation = params[:message][:conversation_id]
      if conversation
        redirect_to dashboard_conversation_url(conversation), :alert => 'Помилка при створенні повідомлення'
      else
        redirect_to dashboard_conversations_url, :alert => 'Помилка при створенні повідомлення'
      end
    end
  end

  private

  def add_service_providers
    @service_providers = ServiceProvider.all
    # @service_providers = current_user.service_providers
  end

end