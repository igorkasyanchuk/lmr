class Admin::PostsController < Admin::DashboardController
  defaults :resource_class => Post, :collection_name => 'posts', :instance_name => 'post'

  def index
    @posts = Post.recent.page(params[:page]).per(20)
  end
 
  
end
