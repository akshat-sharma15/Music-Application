class DropTablePlaylistSongs < ActiveRecord::Migration[7.0]
  def change
    drop_table :playlist_songs
  end
end
