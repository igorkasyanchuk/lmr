class News::FeedController < ApplicationController
  layout nil
  
  def atom
    @posts = Post.recent
    render :template => '/feed/atom.atom.builder'
  end
  
  def rss
    @posts = Post.recent
    render :template => '/feed/atom.atom.builder'
  end
  
end