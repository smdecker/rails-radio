class SearchController < ApplicationController  

	def index
	  q = params[:q]
	  @shows    = Show.search(:title_cont => q).result
	  @episodes = Episode.search(:title_cont => q).result
	  @users    = User.search(:username_cont => q).result

	  array = [@shows,@episodes,@users]

	  @no_results = array.all?{|x| x.empty?}
	end
end 