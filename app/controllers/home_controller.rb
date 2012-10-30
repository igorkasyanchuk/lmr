# encoding: utf-8
class HomeController < ApplicationController

  def index
    @news = Post.last_four
    @main_new = @news.shift
  end

end
