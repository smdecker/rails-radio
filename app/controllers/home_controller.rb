class HomeController < ApplicationController
	def index
		@episodes = Episode.all
		@show = Show.all
		@admin = User.where(admin: true)
	end
end