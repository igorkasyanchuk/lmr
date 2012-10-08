Forem::ForumsController.class_eval do
  def index
    @categories = Forem::Category.includes(:forums)
  end
end