class Song < ApplicationRecord
  has_one_attached :audio
  has_one_attached :poster

  belongs_to :artist

  validates :name, presence: true, length: { maximum: 255 }
  validates :movie, length: { maximum: 255 }
  validates :lyrics, presence: true
end
