class Admin::PostsController < Admin::DashboardController
  defaults :resource_class => Post, :collection_name => 'posts', :instance_name => 'post'

  def index
    @posts = if params[:q].present? 
          Post.where("title like :q or description like :q", :q => "%" + params[:q] + "%")
        else
          Post
        end.recent.page(params[:page]).per(20)
  end
 
 def create
   create! {[:admin, :posts]}
 end

 def update
   update! {[:admin, :posts]}
 end
  
end
