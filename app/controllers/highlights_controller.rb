class HighlightsController < ApplicationController
	def index
		@admin = User.where(admin: true)
	end
end