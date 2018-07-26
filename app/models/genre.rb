class Genre < ApplicationRecord
	has_many :episode_genres
	has_many :episodes, :through => :episode_genres

	extend FriendlyId
  friendly_id :name, use: :slugged

	def episodes_desc
		episodes.order(created_at: :desc)
	end

	def self.genre_order
		Genre.all.order('name ASC')
	end
end
