class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :listing_id
      t.text :body
      t.references :user, index: true

      t.timestamps null: false
    end
    add_index :comments, :listing_id
    add_foreign_key :comments, :users
  end
end
