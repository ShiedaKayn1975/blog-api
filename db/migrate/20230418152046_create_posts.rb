class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :status
      t.references :user, null: false, foreign_key: true
      t.text :content
      t.string :brief

      t.timestamps
    end
    add_index :posts, :status
  end
end
