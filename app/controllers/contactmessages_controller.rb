class ContactmessagesController < ApplicationController
  def create
    @contactmessage = Contactmessage.create(contactmessage_params)
    redirect_to contact_path
  end

  private

  def contactmessage_params
    params.require(:contactmessage).permit(:name, :email, :message);
  end
end
