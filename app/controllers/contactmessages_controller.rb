class ContactmessagesController < ApplicationController
  def create
    @sidebar = 'sidebar-contact-background'
    @contactmessage = Contactmessage.create(contactmessage_params)
    if @contactmessage.valid?
      @contactmessage = Contactmessage.new
      @displayform = 'hide-form'
      render :new
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @sidebar = 'sidebar-contact-background'
    @displayform = 'contact-form'
    @contactmessage = Contactmessage.new
  end

  private

  def contactmessage_params
    params.require(:contactmessage).permit(:name, :email, :message);
  end
end
