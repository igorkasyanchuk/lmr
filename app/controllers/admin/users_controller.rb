# encoding: utf-8

class Admin::UsersController < Admin::DashboardController
  defaults :resource_class => User, :collection_name => 'users', :instance_name => 'user'
  before_filter :admin_required

  def index
    @users = User.scoped
    @users = User.where("identifier like :q or email like :q", :q => "%" + params[:q] + "%") if params[:q].present?
    @users = @users.all
  end

  def update
    update! {[:admin, :users]}
  end

  def destroy
  	destroy! {[:admin, :users]}
  end

  def create
    create! {[:admin, :users]}
  end

  def show
    redirect_to [:edit, :admin, resource]
  end

  def confirm
    resource.confirm!
    redirect_to [:admin, :users], :notice => "Користувача підтвердженно."
  end

  def block
    resource.update_attribute(:blocked, true)
    redirect_to [:admin, :users], :notice => "Користувача заблоковано."
  end

  def unblock
    resource.update_attribute(:blocked, false)
    redirect_to [:admin, :users], :notice => "Користувача розблоковано."
  end

end