# encoding: utf-8
class ActivitiesController < ApplicationController

  def log
    current_user.activities.create(:activity => UserActivity::ACTIVITIES[:login], :ip => request.remote_ip)
    redirect_to my_dashboard_path
  end

end