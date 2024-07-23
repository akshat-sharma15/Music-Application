class Artist < ApplicationRecord
  has_one_attached :poster
  has_many :songs

  validates :name, presence: true
end
