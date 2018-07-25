class HomeController < ApplicationController
	def index
		@episodes = Episode.recent_episodes
		@admin = User.where(admin: true)
	end
end