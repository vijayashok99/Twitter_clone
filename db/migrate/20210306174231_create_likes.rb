class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|

      t.timestamps
    end
    add_reference :likes, :user, null: false, foreign_key: true
    add_reference :likes, :tweet, null: false, foreign_key: true
  end
end
