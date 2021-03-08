class AddTweetReferencesToComments < ActiveRecord::Migration[6.0]
  def change
    add_reference :comments, :tweet, null: false, foreign_key: true
    add_column :comments, :parent_comment_id, :integer
  end
end
