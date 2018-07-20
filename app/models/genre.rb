class Genre < ApplicationRecord
	has_many :episode_genres
	has_many :episodes, :through => :episode_genres

	extend FriendlyId
  friendly_id :name, use: :slugged
end
