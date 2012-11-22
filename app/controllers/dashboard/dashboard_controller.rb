# encoding: utf-8
class Dashboard::DashboardController < InheritedResources::Base
  layout 'dashboard'

  before_filter :authenticate_user!
  before_filter :verify_user_is_active
  
  def welcome
  end

  def pay_services
    @lkps = LkpDepartment.geo_scope(:origin => address).order("distance asc").limit(1).first
    @terminals = Terminal.geo_scope(:origin => address).order("distance asc").limit(1).first
    @banks = BankDepartment.geo_scope(:origin => address).order("distance asc").limit(1).first
  end

  private
  
  def address
    query = current_user.try(:search_address)
    location = Geocoder.search('Львів, ' + query.to_s)
    location = [location[0].latitude, location[0].longitude]    
  end

end
