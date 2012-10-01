class ServicePayment

  attr_accessor :address, :bill_identifier, :bill_period, :fio, :payer_ls, :service_name, :service_code, :company_code, :debt
  
  Debt = Struct.new :provider_account_no, :prepayment, :amount_to_pay, :charge, :debt, :last_paying

  def initialize input
    @address = input['address']
    @bill_identifier = input['bill_identifier']
    @bill_period = input['bill_period']
    @fio = input['fio']

    @payer_ls = input['service']['payer']['ls']

    fill_service_info input['service']
    fill_debt_info input['service']['debt']
  end

  def fill_service_info raw
    @service_name = raw['ks']['service']
    @service_code = raw['ks']['service_code']
    @company_code = raw['ks']['company_code']
  end

  def fill_debt_info raw
    @debt = Debt.new raw['provider_account_no'], raw['prepayment'], raw['amount_to_pay'], raw['charge'], raw['debt'], raw['last_paying']

  end

end
