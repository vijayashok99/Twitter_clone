class AddColumnToLike < ActiveRecord::Migration[6.0]
  def change
    remove_reference :likes, :tweet, index: true, foreign_key: true
    add_reference :likes, :likeable, polymorphic: true, null: false
  end
end
