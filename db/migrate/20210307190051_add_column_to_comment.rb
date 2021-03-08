class AddColumnToComment < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :comment_count, :integer, default: 0
  end
end


