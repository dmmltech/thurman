class ContactsController < ApplicationController
  def index
    @contacts = Contact.all
  end

  def new
  	# @contact = Contact.new
  end

  def create
  	@contact = Contact.new(contact_params)
  	@contact.save
  end

  def contact_params
    params.require(:contact).permit(:email)
  end
end
