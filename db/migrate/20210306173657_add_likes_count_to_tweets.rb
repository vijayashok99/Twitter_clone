class AddLikesCountToTweets < ActiveRecord::Migration[6.0]
  def change
    add_column :tweets, :likes_count, :integer, default: 0
  end
end
