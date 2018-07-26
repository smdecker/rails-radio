class Episode < ApplicationRecord
	belongs_to :user
	belongs_to :show

	has_many :comments

	has_many :favorite_episodes
	has_many :favorited_by, through: :favorite_episodes, source: :user

	has_many :episode_genres
	has_many :genres, :through => :episode_genres

	accepts_nested_attributes_for :genres

	has_attached_file :avatar, styles: { xl: "940x600#", medium: "300x225#", thumb: "172x120#" }, default_url: "/assets/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  validates_presence_of :title, :description, :air_date

	extend FriendlyId
  friendly_id :uniqueslug, use: :slugged

  def uniqueslug
    "#{title}-#{air_date}"
  end

	def should_generate_new_friendly_id?
	 title_changed?
	end

	def most_popular
		self.favorited_by.each_with_index {|u, i| @total = i +=1} 
		@total.to_i
	end

	def self.sorted_by_most_popular
		Episode.all.sort_by {|e| e.most_popular}.reverse
	end

	def self.recent_episodes
		Episode.order(created_at: :desc).first(15)
	end

	def comments_desc
		comments.order(created_at: :desc)
	end

	def self.explore_order
		Episode.order(created_at: :desc)
	end

  def genres_attributes=(genre_attributes)
    genre_attributes.values.each do |genre_attribute|
			if !genre_attribute[:name].blank?
				genre = Genre.find_or_create_by(genre_attribute)
					self.genres << genre
			end
    end
  end
end

# Most popular by week
	# def self.sorted_by_most_popular
	# 	@scoped = Episode.all.where(created_at: 1.week.ago..Time.now)
	# 	@scoped.sort_by {|e| e.most_popular}.reverse
	# end

