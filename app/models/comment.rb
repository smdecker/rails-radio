class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :episode

	validates_presence_of :content
end
