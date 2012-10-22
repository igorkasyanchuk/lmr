class ResponsiblePerson < ActiveRecord::Base
  belongs_to :service_provider

  attr_accessible :first_name, :middle_name, :last_name, :incumbency, :phone, :email
end