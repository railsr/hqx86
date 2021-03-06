class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.request = request
    h = JSON.generate({
      'name' => @contact.name,
      'email' => @contact.email,
      'message' => @contact.message,
      'request_type' => @contact.request_type,
      })

    #edit this 
    respond_to do |format|
      if @contact.valid?
        ContactWorker.perform_async(h)
        format.html { redirect_to root_path, notice: "Thank you for your message." }
      else
        format.html { render :new, error: "There was a problem with sending your message." }
      end
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message, :request_type, :nickname)
  end

end