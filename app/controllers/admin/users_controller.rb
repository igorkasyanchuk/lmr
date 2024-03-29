# encoding: utf-8
class Admin::UsersController < Admin::DashboardController
  defaults :resource_class => User, :collection_name => 'users', :instance_name => 'user'
  before_filter :admin_required, :except => [:autocomplete]
  skip_before_filter :authenticate_user!, :only => [:autocomplete]
  skip_before_filter :admin_or_moderator_required, :only => [:autocomplete]

  def index    
    @users = if params[:q].present? 
        User.where("identifier like :q or email like :q or name like :q or surname like :q", :q => "%" + params[:q] + "%")
      else
        User
      end.includes(:role).page(params[:page]).per(20)
  end

  def update
    update! {[:admin, :users]}
  end

  def destroy
    if resource == current_user
      redirect_to [:admin, :users], :alert => "Ви не можете видалити себе."
    else
      destroy! {[:admin, :users]}
    end  	
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
    if resource == current_user
      redirect_to [:admin, :users], :alert => "Ви не можете заблокувати себе."
    else
      resource.update_attribute(:blocked, true)
      redirect_to [:admin, :users], :notice => "Користувача заблоковано."
    end
  end

  def unblock
    resource.update_attribute(:blocked, false)
    redirect_to [:admin, :users], :notice => "Користувача розблоковано."
  end

  def time_unblock
    resource.unlock_access!
    redirect_to [:admin, :users], :notice => "Тимчасове блокування користувача знято."
  end

  def autocomplete
    if params[:street]
      houses = House.where("street_id = ? AND number_code LIKE ?","#{params[:street]}", "#{params[:term]}%").order("number_code")
      render :json => houses.map { |h| {:id => h.id, :label => "#{h.number_code}"} }
    else
      streets = Street.where("name LIKE ?", "#{params[:term]}%").order("name")
      render :json => streets.map { |s| {:id => s.id, :label => "#{s.name}"} }
    end
  end

end