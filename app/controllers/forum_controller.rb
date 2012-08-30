class ForumController < ApplicationController
	before_filter :moderator_or_admin

	def index
		@users = User.where(:forem_state => 'spam')
	end
	
	def autocomplete
		search_field = 'email'
    users = User.where("#{search_field} LIKE ? AND forem_state = ?", "%#{params[:term]}%", 'approved').limit(10).
      select("id, #{search_field}").order("#{search_field}")
    # render :json => users.map { |u| u.send(search_field) }
    render :json => users.map { |u| {:id => u.id, :label => u.send(search_field)} }
  end

  def toggle_approve
    user = User.find(params[:id])
    @users = User.where(:forem_state => 'spam')

    if user.forem_state == 'approved'
      user.update_attribute(:forem_state, "spam")
    else
      user.update_attribute(:forem_state, "approved")
    end
    
    respond_to :js
  end

  private

  def moderator_or_admin
    unless current_user.forem_admin? || current_user.has_role?('content_manager')
      redirect_to forem_path
    end
  end

  
end