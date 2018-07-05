class HomeController < ApplicationController
	def index
		@episodes = Episode.all
		@admin = User.where(admin: true)
	end
end