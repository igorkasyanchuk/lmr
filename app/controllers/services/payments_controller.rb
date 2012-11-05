# encoding: utf-8
class Services::PaymentsController < ApplicationController

  def payments
  end

  def bank_departments
    @departments = BankDepartment.all
  end

  def lkp_departments
    @departments = LkpDepartment.all
  end

  def terminals
    @departments = Terminal.all
  end

  def web_payments
  end

  def search
  end

end