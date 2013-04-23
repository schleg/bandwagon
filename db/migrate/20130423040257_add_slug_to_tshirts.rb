class AddSlugToTshirts < ActiveRecord::Migration
  def change
    add_column :tshirts, :slug, :string
    add_index :tshirts, :slug, unique: true
  end
end
