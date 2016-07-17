class StaticPagesController < ApplicationController
  before_action :authenticate_admin!, only: [:admin]
  def index
    @sidebar = 'sidebar-index-background'
  end

  def admin
    @messages = Contactmessage.all
    @blogposts = Blogpost.all
    render(:layout => "layouts/blogposts")
  end
end
