class BlogpostsController < ApplicationController  
  layout "blogposts"
  #use this layout for all
  def index
    @blogposts = Blogpost.all
    @sidebar = 'sidebar-blog-background'
    render(:layout => "layouts/application")
    #Action specific layout
  end

  def show 
    @sidebar = 'sidebar-blog-background'
    @blogpost = Blogpost.find(params[:id])
  end
end
