class AddReferenceOfArtistToSongs < ActiveRecord::Migration[7.0]
  def change
    add_reference  :songs, :artists, null:false
  end
end
