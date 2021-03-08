class AddColumnToTweets < ActiveRecord::Migration[6.0]
  def change
    add_column :tweets, :image_url, :string
    change_column :tweets, :tweet, :text, :null => true
  end
end
