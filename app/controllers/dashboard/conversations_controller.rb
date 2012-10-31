# encoding: utf-8
class Dashboard::ConversationsController < Dashboard::DashboardController
  def index
    @conversations = current_user.conversations
  end

  def new
    @conversation = Conversation.new
    @service_providers = ServiceProvider.all
  end

  def create
    body = params[:conversation][:body]
    service_provider = params[:conversation][:service_provider_id]
    subject = params[:conversation][:subject]
    token = SecureRandom.hex(10)
    @conversation = Conversation.new(user_id: current_user.id, service_provider_id: service_provider, token: token, subject: subject)
    message = Message.create(body: body, from: current_user.full_name)    
    if @conversation.save
      @conversation.messages << message  
      redirect_to dashboard_conversation_url(@conversation)
    else
      render :action => :new
    end
  end

  def show
    @conversation = Conversation.find(params[:id])
    @messages = @conversation.messages
  end

  def message
    conversation = Conversation.find_by_id(params[:message][:conversation_id])
    message = Message.new(body: params[:message][:body], from: current_user.full_name)    
    if conversation.present? && message.save
      conversation.messages << message
      redirect_to dashboard_conversation_url(conversation)
    else
      redirect_to dashboard_conversations_url, :alert => 'Помилка при створенні повідомлення'
    end
  end


end