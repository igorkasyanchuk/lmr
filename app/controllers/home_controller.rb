# encoding: utf-8
class HomeController < ApplicationController

  def index
    @news = Post.last_five
    @main_new = @news.shift
  end

end
