# encoding: utf-8
class Services::PaymentsController < ApplicationController

  def payments
  end

  def bank_departments
    @departments = BankDepartment.all
    prepare_marker
  end

  def lkp_departments
    @departments = LkpDepartment.all
    prepare_marker
  end

  def terminals
    @departments = Terminal.all
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