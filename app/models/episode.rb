class Episode < ApplicationRecord
	belongs_to :user
	belongs_to :show

	has_many :comments

	has_many :favorite_episodes
	has_many :favorited_by, through: :favorite_episodes, source: :user

	extend FriendlyId
  friendly_id :title, use: :slugged

	def most_popular
		self.favorited_by.each_with_index {|u, i| @total = i +=1} 
		@total.to_i
	end

	def self.sorted_by_most_popular
		Episode.all.sort_by {|e| e.most_popular}.reverse
	end
end

# Most popular by week
	# def self.sorted_by_most_popular
	# 	@scoped = Episode.all.where(created_at: 1.week.ago..Time.now)
	# 	@scoped.sort_by {|e| e.most_popular}.reverse
	# end

