class Song < ApplicationRecord
  has_one_attached :audio
  has_one_attached :poster

  has_many :playlist_songs
  has_many :playlists, through: :playlist_songs
end
