class BlogpostsController < ApplicationController  
  layout "blogposts"
  #use this layout for all
  def index
    @blogposts = Blogpost.all.select(&:publish_date).sort_by(&:publish_date).reverse!
    @sidebar = 'sidebar-blog-background'
    render(:layout => "layouts/application")
    #Action specific layout
  end

  def show 
    @comments = Comment.all
    @sidebar = 'sidebar-blog-background'
    @blogpost = Blogpost.find_by_id(params[:id])
    return render_not_found unless @blogpost.present?
  end
end
