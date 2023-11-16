class AddYearToArtworks < ActiveRecord::Migration[7.1]
  def change
    add_column :artworks, :year, :string
  end
end
