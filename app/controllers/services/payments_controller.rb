# encoding: utf-8
class Services::PaymentsController < ApplicationController

  def payments
  end

  def bank_departments
    @departments = BankDepartment.all
    prepare_marker
  end

  def lkp_departments
    @departments = LkpDepartment.all
    prepare_marker
  end

  def terminals
    @departments = Terminal.all
    prepare_marker
  end

  def web_payments
  end

  def search
    @departments = PaymentTerminal.all
    prepare_marker
  end

  def prepare_marker
    @markers = @departments.to_gmaps4rails
  end

end