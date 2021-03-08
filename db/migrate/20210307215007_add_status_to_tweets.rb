class AddStatusToTweets < ActiveRecord::Migration[6.0]
  def change
    add_column :tweets, :status, :integer, null: false, default: 0
  end
end
