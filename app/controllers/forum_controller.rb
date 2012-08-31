# encoding: utf-8
class ForumController < ApplicationController
	before_filter :moderator_or_admin

	def index
		@users = User.where(:forem_state => 'spam').order("surname")
	end
	
	def autocomplete
		role_field = current_user.admin? ? '%' : 'user'
    users = User.joins(:role).
    				where("(email LIKE ? OR surname LIKE ?) AND forem_state = ? AND roles.name LIKE ?", "%#{params[:term]}%", "%#{params[:term]}%", 'approved', "#{role_field}")
    				.limit(10).select("users.id, users.name, users.surname, users.email").order("users.surname")
    render :json => users.map { |u| {:id => u.id, :label => "#{u.surname} #{u.name} (#{u.email})"} }
  end

  def toggle_approve
    user = User.find(params[:id])
    @users = User.where(:forem_state => 'spam').order("surname")

    if user.forem_state == 'approved'
      user.update_attribute(:forem_state, "spam")
    else
      user.update_attribute(:forem_state, "approved")
    end
    
    respond_to :js
  end

  private

  def moderator_or_admin
    unless (current_user.forem_admin? || current_user.has_role?('content_manager')) && !current_user.blocked?
    	flash.alert = t("forem.errors.access_denied")
      redirect_to forem_path
    end
  end

  
end