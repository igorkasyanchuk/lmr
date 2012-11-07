#encoding: utf-8
class PaymentTerminal < ActiveRecord::Base
  attr_accessible :code, :name, :address, :phone, :bank, :email, :payment_type, :type

  acts_as_gmappable
  acts_as_mappable :lat_column_name => :latitude,
                   :lng_column_name => :longitude

  TERMINAL_TYPES = {
    'Terminal' => 'Термінал',
    'LkpDepartment' => 'Каса ЛКП',
    'BankDepartment' => 'Банківське Відділення'
  }

  validates :name, :presence => true, :length => {:in => 5..200}
  validates :type, :presence => true
  validates :code, :presence => true
  validates :address, :presence => true

  def gmaps4rails_address
    "#{self.address}"
  end

  def gmaps4rails_title
    "#{self.name}, #{self.address}"
  end



end