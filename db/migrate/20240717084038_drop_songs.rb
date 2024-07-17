class DropSongs < ActiveRecord::Migration[7.0]
  def change
    drop_table :songs
  end
end
