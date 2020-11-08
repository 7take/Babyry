class FavoritesController < ApplicationController
	def create
		@baby = Baby.find(params[:baby_id])
		@favorites = current_user.favorites.create(baby_id: params[:baby_id])
		# redirect_back(fallback_location: root_path)
	end

	def destroy
		@baby = Baby.find(params[:baby_id])
		@favorite = current_user.favorites.find_by(baby_id: @baby.id)
		@favorite.destroy
		# redirect_back(fallback_location: root_path)
	end
end
