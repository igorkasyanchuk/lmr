# encoding: utf-8
class Services::PaymentsController < ApplicationController

  def payments
  end

  def bank_departments
    @markers = BankDepartment.all.to_gmaps4rails
    @departments = BankDepartment.all
  end

  def lkp_departments
    @markers = LkpDepartment.all.to_gmaps4rails
    @departments = LkpDepartment.all
  end

  def terminals
    @markers = Terminal.all.to_gmaps4rails
    @departments = Terminal.all
  end

  def web_payments
  end

  def search
    @markers = PaymentTerminal.all.to_gmaps4rails
  end

end