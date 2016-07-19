class CommentsController < ApplicationController
  def create
    @blogpost = Blogpost.find_by_id(params[:blogpost_id])
    if @blogpost.blank?
      return render_not_found
    end
    @blogpost.comments.create(comment_params)
    redirect_to blogpost_path(@blogpost)
  end

  private

  def comment_params
    params.require(:comment).permit(:name, :message)
  end
end
