class ContactmessagesController < ApplicationController
  def create
    @sidebar = 'sidebar-contact-background'
    @contactmessage = Contactmessage.create(contactmessage_params)
    if @contactmessage.valid?
      redirect_to new_contactmessage_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @sidebar = 'sidebar-contact-background'
    @contactmessage = Contactmessage.new
  end

  private

  def contactmessage_params
    params.require(:contactmessage).permit(:name, :email, :message);
  end
end
