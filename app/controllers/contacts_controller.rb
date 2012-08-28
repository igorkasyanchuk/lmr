class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    if @contact.save_with_captcha
      redirect_to '/', :notice => "Thank You for Your message!"
    else
      render :new
    end
  end
end