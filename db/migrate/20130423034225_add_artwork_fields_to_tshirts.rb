class AddArtworkFieldsToTshirts < ActiveRecord::Migration
  def change
    add_column :tshirts, :artwork, :string
    add_column :tshirts, :art_file_name, :string
    add_column :tshirts, :art_content_type, :string
    add_column :tshirts, :art_file_size, :integer
    add_column :tshirts, :art_updated_at, :datetime
  end
end
