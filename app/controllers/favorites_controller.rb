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




















	# def create 
	# 	favorite = Favorite.find_by(product_id: params[:product_id], user_id: params[:product_id])
	# 	  if existing_vote.present?
	#       existing_vote.upvotes = params[:upvotes] if params.key?(:upvotes)
	#       existing_vote.downvotes = params[:downvotes] if params.key?(:downvotes)
	# 	  	existing_vote.save
	# 		  render json: BxBlockUpvotedownvote::VoteSerializer.new(existing_vote).as_json, status: :ok
  #     else
  #       vote = BxBlockUpvotedownvote::Vote.new(vote_params)
	# 	  	if vote.save
 	# 	  		render json: BxBlockUpvotedownvote::VoteSerializer.new(vote), status: :ok
	# 	  	else
	# 	  		render json: { errors: vote.errors.full_messages }, status: 503
	# 	  	end
	# 	  end
	# 	end

	# 	private

  #   def vote_params
  #   	params.permit(:course_id, :account_id, :upvotes, :downvotes)
  #   end
