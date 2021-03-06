class Admin::BlogpostsController < ApplicationController
  before_action :authenticate_admin!
  def new
    @blogpost = Blogpost.new
  end

  def create
    @blogpost = Blogpost.create(blogpost_params)
    if @blogpost.valid?
      redirect_to admin_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @blogpost = Blogpost.find_by_id(params[:id])
    render_not_found unless @blogpost.present?
  end

  def update
    @blogpost = Blogpost.find_by_id(params[:id])
    return render_not_found unless @blogpost.present?
    @blogpost.update_attributes(blogpost_params)      
    if @blogpost.valid?
      redirect_to admin_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @blogpost = Blogpost.find_by_id(params[:id])
    return render_not_found unless @blogpost.present?
    @blogpost.destroy
    redirect_to admin_path
  end

  def publish
    @blogpost = Blogpost.find_by_id(params[:blogpost_id])
    return render_not_found unless @blogpost.present?
    publish = !@blogpost.published
    publish_date = publish == true ? Date.current() : nil
    @blogpost.update_attributes({:published => publish, :publish_date => publish_date})
    redirect_to admin_path
  end

  private

  def blogpost_params
    params.require(:blogpost).permit(:title, :content, :category, :image, :published, :publish_date)
  end
end
