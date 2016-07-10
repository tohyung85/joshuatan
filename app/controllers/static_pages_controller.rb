class StaticPagesController < ApplicationController
  def index
    @sidebar = 'sidebar-index-background'
  end

  def contact
    @sidebar = 'sidebar-contact-background'
    @contactMessage = Contactmessage.new
  end
end
