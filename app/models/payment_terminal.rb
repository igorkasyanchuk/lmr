#encoding: utf-8
class PaymentTerminal < ActiveRecord::Base
  attr_accessible :code, :name, :address, :phone, :bank, :email, :payment_type, :type

  TERMINAL_TYPES = {
    'Terminal' => 'Термінал',
    'LkbDepartment' => 'Каса ЛКБ',
    'BankDepartment' => 'Банківське відділення'
  }
end