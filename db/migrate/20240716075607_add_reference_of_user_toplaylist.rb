class AddReferenceOfUserToplaylist < ActiveRecord::Migration[7.0]
  def change
    add_reference  :playlists, :users, null:false
  end
end
