class Admin::BlogpostsController < ApplicationController
  before_action :authenticate_admin!
  def new
    @blogpost = Blogpost.new
  end

  def create
    @blogpost = Blogpost.create(blogpost_params)
    redirect_to new_admin_blogpost_path
  end

  private

  def blogpost_params
    params.require(:blogpost).permit(:title, :content)
  end
end
