class Admin::UsersController < Admin::DashboardController
  before_filter :admin_required

  def index
  	@users = User.all
  end

  def new
  	@user = User.new
  end

  def edit
  	@user = User.find(params[:id])
  end

  def create
    create! {[:admin, :users]}
  end

  def update
  	@user = User.find(params[:id])
    update! {[:admin, :users]}
  end
  def destroy
  	@user = User.find(params[:id])
  	destroy! {[:admin, :users]}
  end
end