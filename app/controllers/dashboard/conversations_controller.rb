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
    @conversation = current_user.conversations.new(params[:conversation])
    if @conversation.save
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
    @conversation = current_user.conversations.find(params[:id])

    if @conversation.present? 
      if @conversation.reply_with_form params[:message]
        redirect_to dashboard_conversation_url(@conversation)
      else
        redirect_to dashboard_conversation_url(@conversation), :alert => 'Помилка при створенні повідомлення'
      end
    else
      redirect_to dashboard_conversations_url, :alert => 'Помилка при створенні повідомлення'
    end

  end

  private

  def add_service_providers
    @service_providers = current_user.service_providers
  end

end
