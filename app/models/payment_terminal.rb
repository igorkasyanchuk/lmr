#encoding: utf-8
class PaymentTerminal < ActiveRecord::Base
  attr_accessible :code, :name, :address, :phone,
                  :bank, :email, :payment_type,
                  :type, :latitude, :longitude,
                  :department, :district

  acts_as_gmappable
  acts_as_mappable :default_units => :kms,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude

  TERMINAL_TYPES = {
    'Відділення банку' => 'BankDepartment',    
    'Каса ЛКП' => 'LkpDepartment',
    'Термінал' => 'Terminal'
  }

  validates :name, :presence => true, :length => {:in => 5..200}
  validates :type, :presence => true
  validates :address, :presence => true
  validate :lat_lon_coordinates , :on => :create

  def gmaps4rails_address
    "#{address}"
  end

  def gmaps4rails_title
    add = type == 'LkpDepartment' ? ", #{district} район" : ''
    "#{name}, #{address}#{add}"
  end

  def gmaps4rails_infowindow
    add = type == 'LkpDepartment' ? "</br> #{district} район" : ''
    "#{name}, </br>#{address}#{add}</br> #{phone}"
  end

  private

  def lat_lon_coordinates
    unless self.latitude.present? && self.longitude.present?
      errors.add :address, "неможливо знайти координати адреси"
    end
  end



end