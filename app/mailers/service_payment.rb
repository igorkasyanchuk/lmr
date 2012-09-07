class ServicePayment

  attr_accessor :address, :bill_identifier, :bill_period, :fio, :payer_ls, :service_name, :service_code, :company_code, :debt
  
  Debt = Struct.new :provider_account_no, :prepayment, :amount_to_pay, :charge, :debt, :last_paying

  def initialize input
    @address = input['address']
    @bill_identifier = input['bill_identifier']
    @bill_period = input['bill_period']
    @fio = input['fio']

    @payer_ls = input['service']['payer']['ls']

    service_ks = input['service']['ks']

    @service_name = service_ks['service']
    @service_code = service_ks['service_code']
    @company_code = service_ks['company_code']

    debt_info = input['service']['debt']

    @debt = Debt.new debt_info['provider_account_no'], debt_info['prepayment'], debt_info['amount_to_pay'], debt_info['charge'], debt_info['debt'], debt_info['last_paying']

  end

end
