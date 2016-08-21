class UsersController < ApplicationController
  def create
    hash_id = SecureRandom.uuid
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
      project_arr = User.render_projects_in_order(user)
      render json: project_arr
    else
      render json: { message: "User not found" }
    end
  end

  def update_position_order
    user = User.find_by(hash_id: params[:hash_id])
    if (params[:order_string])
      user.update_attributes(position_order: params[:order_string])
      project_arr = User.render_projects_in_order(user)
      render json: project_arr
    else
      render json: { message: "something went wrong" }
    end
  end
  # private
  # def hash_id_params
  #   params.permit(:id)
  # end
end
