class EpisodeGenre < ApplicationRecord
	belongs_to :episode
	belongs_to :genre
end
