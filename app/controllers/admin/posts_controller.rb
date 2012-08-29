class Admin::PostsController < InheritedResources::Base

  layout 'admin'
  before_filter :authenticate_user!

  def index
    @posts = Post.recent.page(params[:page]).per(20)
  end
 
  
end
