#encoding: utf-8
class PaymentTerminal < ActiveRecord::Base
  attr_accessible :code, :name, :address, :phone, :bank, :email, :payment_type, :type

  TERMINAL_TYPES = {
    'Terminal' => 'Термінал',
    'LkpDepartment' => 'Каса ЛКП',
    'BankDepartment' => 'Банківське Відділення'
  }

  validates :name, :presence => true, :length => {:in => 5..200}
  validates :type, :presence => true
  validates :code, :presence => true

end