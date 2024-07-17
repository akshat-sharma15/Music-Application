class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :poster
  include Devise::JWT::RevocationStrategies::JTIMatcher
  validates :name, presence: true
  validates :dob, presence: true

  devise :database_authenticatable, :registerable, :recoverable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self
  has_many :playlists
end
