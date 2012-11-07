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
    @departments = PaymentTerminal.within(5, :origin => location).all
    @departments = PaymentTerminal.geo_scope(:origin => location).order("distance asc").limit(5) if @departments.blank?
    prepare_marker
  end

  
  private
    def prepare_marker
      @markers = @departments.to_gmaps4rails
    end

    def prepare_coordinates query
      location = Geocoder.search('Lviv, ' + query.to_s) 
      location = location[0].geometry['location'].map {|k,v| v}
    end

end