class ContactsController < ApplicationController
  before_action :authenticate_user!, :only => [:manage,:edit,:update,:destroy,:delete]

  def index
    @contacts = Contact.all
  end

  def manage
    @contacts = Contact.order(:created_at)
    respond_to do |format|
      format.html
      format.csv { send_data @contacts.as_csv, filename: "contacts-#{Date.today}.csv" }
    end
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
