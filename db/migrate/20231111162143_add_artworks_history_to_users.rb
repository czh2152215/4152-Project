class AddArtworksHistoryToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :artworks_history, :text
  end
end
