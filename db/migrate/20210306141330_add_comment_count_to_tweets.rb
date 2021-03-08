class AddCommentCountToTweets < ActiveRecord::Migration[6.0]
  def change
    add_column :tweets, :comment_count, :integer, default: 0
  end
end
