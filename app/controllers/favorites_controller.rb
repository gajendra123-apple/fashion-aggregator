class FavoritesController < ApplicationController
  # before_action :authenticate_user, only: [:create]
	before_action :find_favorite, only: [:show]

	def create
		exit_favorite = Favorite.find_by(product_id: params[:product_id], user_id: params[:user_id])
	  if exit_favorite.present?
	  	exit_favorite.update(like_params)
		   render json: FavoriteSerializer.new(exit_favorite).as_json, status: :ok

    else
      like = Favorite.new(like_params)
	  	if like.save
		   		render json: FavoriteSerializer.new(like), status: :ok
	  	else
	  		render json: { errors: like.errors.full_messages }, status: :unprocessable_entity
	  	end
	  end
	end

	def index
		# @user =current_user.favorite
		# @favorites = @user.where(is_favorite: true)
	  @favorites = Favorite.where(is_favorite: true)
	  render json: @favorites, each_serializer: FavoriteSerializer, status: :ok
  end

  def show
	 render json: @favorite, status: 200
	end

	private

  def like_params
  	params.permit(:product_id, :user_id, :is_favorite)
  end

  def find_favorite
   @favorite = Favorite.find_by(id: params[:id])
  	return render json: {message: "favorite with id #{params[:id]} not found"}, status:404 unless @favorite 
  end
end
