class Admin::BlogpostsController < ApplicationController
  before_action :authenticate_admin!
  def new
    @blogpost = Blogpost.new
  end

  def create
    @blogpost = Blogpost.create(blogpost_params)
    if @blogpost.valid?
      redirect_to new_admin_blogpost_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def blogpost_params
    params.require(:blogpost).permit(:title, :content, :category)
  end
end
