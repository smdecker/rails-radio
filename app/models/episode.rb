class Episode < ApplicationRecord
	belongs_to :user
	belongs_to :show

	has_many :comments

	has_many :favorite_episodes
	has_many :favorited_by, through: :favorite_episodes, source: :user

	extend FriendlyId
  friendly_id :title, use: :slugged
end
