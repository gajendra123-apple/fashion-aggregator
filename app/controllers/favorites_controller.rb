class FavoritesController < ApplicationController
    include Authentication
	before_action :find_favorite, only: [:show]

	def create
		existing_favorite = Favorite.find_by(product_id: params[:product_id], user_id: current_user.id)
		if existing_favorite.present?
		  if existing_favorite.update(like_params)
			render json: FavoriteSerializer.new(existing_favorite).as_json, status: :ok
		  else
			render json: { errors: existing_favorite.errors.full_messages }, status: :unprocessable_entity
		  end
		else
		  favorite = Favorite.new(like_params.merge(user_id: current_user.id, product_id: params[:product_id]))
		  if favorite.save
			render json: FavoriteSerializer.new(favorite).as_json, status: :ok
		  else
			render json: { errors: favorite.errors.full_messages }, status: :unprocessable_entity
		  end
		end
	end

	def index
		@user =current_user.favorites
		@favorites = @user.where(is_favorite: true)
	  render json: @favorites, each_serializer: FavoriteSerializer, status: :ok
	end
	
	def show
	 render json: @favorite, status: 200
	end

	private
	
	def like_params
		params.permit(:is_favorite)
	end
	
	def find_favorite
		@favorite = Favorite.find_by(id: params[:id])
		return render json: {message: "favorite with id #{params[:id]} not found"}, status:404 unless @favorite 
	end
end