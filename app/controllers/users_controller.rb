class UsersController < ApplicationController
  def create
    hash_id = SecureRandom.base64
    user = User.new(hash_id: hash_id)
    if user.valid?
      user.save
      render json: { hash_id: hash_id, user_object: user.projects }
    else
      render json: { message: "something went wrong" }
    end
  end

  def show
    user = User.find_by(hash_id: params[:id])
    if params[:id] && user
      render json: user.projects
    else
      render json: { message: "User not found" }
    end
  end

  # private
  # def hash_id_params
  #   params.permit(:id)
  # end
end
