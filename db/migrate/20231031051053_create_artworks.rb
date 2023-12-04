class CreateArtworks < ActiveRecord::Migration[7.1]
  def change
    create_table :artworks do |t|
      t.string :artwork_name
      t.text :background_information
      t.string :author
      t.string :image_url
      t.timestamps
    end
  end
end
