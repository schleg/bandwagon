class CreateTshirts < ActiveRecord::Migration
  def change
    create_table :tshirts do |t|
      t.string :title
      t.text :description
      t.string :state
      t.integer :user_id

      t.timestamps
    end
  end
end
