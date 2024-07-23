class Playlist < ApplicationRecord
  has_many :playlist_song

  validates :name, presence: true, length: { maximum: 255 }
  validates :user_id, presence: true
end
