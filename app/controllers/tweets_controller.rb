class TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet, only: %i[ edit update destroy ]

  def index
    @new_tweet = Tweet.new
    @tweets = Tweet.unscoped.joins(:user).where(status: Tweet.statuses[:PUBLISHED]).select("tweets.id, tweets.user_id, tweets.tweet, tweets.likes_count, tweets.comment_count, tweets.image_url, tweets.created_at, users.name, users.user_name").order("tweets.created_at desc")
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    respond_to do |format|
      if @tweet.save
        format.html { redirect_to tweets_path, notice: "Tweet was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: "Tweet was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tweet.update(status: Tweet.statuses[:DISCARDED])
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: "Tweet was successfully destroyed." }
    end
  end

  def show
    @tweet = Tweet.unscoped.joins(:user).where(id: params[:id]).select("tweets.id, tweets.tweet, tweets.created_at, users.name, users.user_name").first
    @comments = Comment.unscoped.joins(:user).where("tweet_id = ? and parent_comment_id is null", params[:id]).select("comments.id, comments.user_id, comments.likes_count, comments.comment_count, comments.comment, comments.created_at, users.name, users.user_name").order("comments.updated_at desc")
  end

  def edit
  end

  private
    def set_tweet
      @tweet = Tweet.find_by_id(params[:id])
    end

    def tweet_params
      params.require(:tweet).permit(:tweet, :image_url).merge(user_id: current_user.id, status: Tweet.statuses[:PUBLISHED])
    end
end
