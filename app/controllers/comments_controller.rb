class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @tweet = Tweet.find_by(id: params[:tweet_id])
    @parent_comment_id = params[:parent_comment_id].present? ? params[:parent_comment_id] : nil
    @comment = Comment.new(tweet: @tweet)
  end

  def create
    @tweet = Tweet.find_by(id: params[:tweet_id])
    @comment = Comment.new(comment_params)
    @comment.parent_comment_id = params[:parent_comment_id] if params[:parent_comment_id].present?
    respond_to do |format|
      if @comment.save
        format.html { redirect_to tweet_path(@tweet.id), notice: "Comment created" }
      else
        format.html { redirect_to tweet_path(@tweet.id), notice: @comment.errors.full_messages.to_sentence }
      end
    end
  end

  def edit
    @tweet = Tweet.find_by_id(params[:tweet_id])
    @comment = Comment.find_by_id(params[:id])
  end

  def update
    @comment = Comment.find_by_id(params[:id])
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to tweet_path(params[:tweet_id]), notice: "Comment was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def show
    @tweet = Tweet.find_by_id(params[:tweet_id])
    @comment = Comment.unscoped.joins(:user).where(id: params[:id]).select("comments.id, comments.user_id, comments.comment, comments.created_at, users.name, users.user_name").first
    @replies = Comment.unscoped.joins(:user).where(tweet_id: params[:tweet_id], parent_comment_id: @comment.id).select("comments.id, comments.user_id, comments.likes_count, comments.comment_count, comments.comment, comments.created_at, users.name, users.user_name").order("comments.updated_at desc")
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to tweet_path(params[:tweet_id]), notice: "Comment was successfully destroyed." }
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:comment).merge(user_id: current_user.id, tweet_id: params[:tweet_id])
    end

end
