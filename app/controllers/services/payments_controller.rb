# encoding: utf-8
class Services::PaymentsController < ApplicationController

  def payments
  end

  def bank_departments
    @departments = if current_user
      address = prepare_coordinates(current_user.try(:search_address))
      BankDepartment.geo_scope(:origin => address).order("distance asc")
    else
      BankDepartment.all
    end
    prepare_marker
  end

  def lkp_departments
    @departments = if current_user
      address = prepare_coordinates(current_user.try(:search_address))
      LkpDepartment.geo_scope(:origin => address).order("distance asc")
    else
      LkpDepartment.all
    end
    prepare_marker
  end

  def terminals
    @departments = if current_user
      address = prepare_coordinates(current_user.try(:search_address))
      Terminal.geo_scope(:origin => address).order("distance asc")
    else
      Terminal.all
    end    
    prepare_marker
  end

  def web_payments
  end

  def search
    location = prepare_coordinates(params[:query])
    @departments = location.empty? ? PaymentTerminal.all : PaymentTerminal.geo_scope(:origin => location).order("distance asc").limit(5)
    prepare_marker
  end

  
  private
    def prepare_marker
      @markers = @departments.to_gmaps4rails
    end

    def prepare_coordinates query
      unless query.to_s.gsub(' ','') == ''
        location = Geocoder.search('Львів, ' + query.to_s)
        location = [location[0].latitude, location[0].longitude]
      else
        []
      end
    end

end