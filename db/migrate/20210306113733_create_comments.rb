class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.string :comment

      t.timestamps
    end
    add_reference :comments, :user, null: false, foreign_key: true
    add_reference :comments, :tweet, null: false, foreign_key: true
  end
end
