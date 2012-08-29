class News::PostsController < InheritedResources::Base

  def index
    @posts = Post.published.page(params[:page]).per(10)
  end

end