class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post

  def create
    record_likes = @record.likes.where(user_id: current_user.id)
    if record_likes.exists?
      record_likes.first.destroy
    else
      record_likes.create(user_id: current_user.id)
    end
    return render json: { success: true, likes_count: @record.likes_count }
    # respond_to do |format|
    #   format.html { redirect_to request.referrer }
    # end
  end

  private
  def find_post
    if params[:comment_id].present?
      @record = Comment.find_by_id(params[:comment_id])
    else
      @record = Tweet.find_by_id(params[:tweet_id])
    end
  end

end