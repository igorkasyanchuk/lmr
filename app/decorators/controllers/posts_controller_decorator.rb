Forem::PostsController.class_eval do
  before_filter :block_spammers, :only => [:new, :create, :edit, :update, :destroy]
end