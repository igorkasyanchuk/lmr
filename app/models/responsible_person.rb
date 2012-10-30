class ResponsiblePerson < ActiveRecord::Base

  belongs_to :service_provider
  self.table_name = 'responsible_persons'

  attr_accessible :first_name, :middle_name, :last_name, :incumbency, :phone, :email


end