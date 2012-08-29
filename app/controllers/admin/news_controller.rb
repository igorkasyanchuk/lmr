class Admin::NewsController < InheritedResources::Base
  layout 'admin'

  before_filter :authenticate_user!

  def index
    @news = ''     
  end   
  
end
