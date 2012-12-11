# encoding: utf-8
class Services::PaymentsController < ApplicationController

  def web_payments; end

  %w{bank_department lkp_department terminal}.each do |payment|
    define_method payment.pluralize do
      group_field = payment == 'bank_department' ? :department : :district
      if current_user && current_user.is_user?
        address = prepare_coordinates(current_user.try(:search_address))
        @departments = payment.camelize.constantize.geo_scope(:origin => address).order("distance asc")
        instance_variable_set("@#{payment.pluralize}".to_sym,
                               @departments.group_by{ |b| b.send(group_field) }.sort_by{|k, v| v.first.distance } )
      else
        @departments = payment.camelize.constantize.all
        instance_variable_set("@#{payment.pluralize}".to_sym, @departments.group_by{ |b| b.send(group_field) } )
      end
      prepare_marker
    end
  end

  def search
    location = prepare_coordinates(params[:query])
    @departments = location.empty? ? PaymentTerminal.all : PaymentTerminal.geo_scope(:origin => location).order("distance asc").limit(5)
    prepare_marker
  end

  def autocomplete
    render :json => BankDepartment.where("department LIKE ?", "#{params[:term]}%").map(&:department).uniq
  end

  
  private
    def prepare_marker
      @markers = @departments.to_gmaps4rails
    end

    def prepare_coordinates query
      unless query.to_s.gsub(' ','') == ''
        geo = Geocoder.search('Львів, ' + query.to_s)[0]
        [geo.latitude, geo.longitude]
      else
        []
      end
    end

end