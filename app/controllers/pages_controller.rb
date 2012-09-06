class PagesController < ApplicationController
  def show
    @page = Page.find_by_identifier params[:id]
    raise ActiveRecord::RecordNotFound unless @page
  end
end
