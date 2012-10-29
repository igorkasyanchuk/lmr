class PaymentTerminal < ActiveRecord::Base
  attr_accessible :code, :name, :address, :phone, :bank, :email, :payment_type
end