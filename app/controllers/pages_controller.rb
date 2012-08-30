class PagesController < ApplicationController
  def show
    @page = Page.find_by_url_title params[:id]
  end
end
