module Admin
  class ActivitiesController < DashboardController
    def index
      @activities = UserActivity.ordered.page(params[:page]).per(15).includes(:user)
      @activities = @activities.where(:activity => params[:q]) unless params[:q].blank?
    end
  end
end
