class RenameColoumnInPlayList < ActiveRecord::Migration[7.0]
  def change
    rename_column :playlists, :users_id, :user_id
  end
end
