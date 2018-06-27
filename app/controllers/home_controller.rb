class HomeController < ApplicationController
	def index
		@episodes = Episode.all
	end
end