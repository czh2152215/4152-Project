class RemoveUidFromArtworks < ActiveRecord::Migration[7.1]
  def change
    remove_column :artworks, :uid, :string
  end
end
