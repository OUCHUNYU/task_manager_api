class ProjectsController < ApplicationController

  def create
    user = User.find_by(hash_id: create_action_params[:hash_id])
    if user
      reconstructed_params = {
        name:        create_action_params[:name],
        description: create_action_params[:description]
      }
      new_project = user.projects.new(reconstructed_params)
      if new_project.valid?
        user.save
        render json: { user_object: user.projects }
      else
        render json: { message: "something went wrong" }
      end
    else
        render json: { message: "user not found" }
    end
  end

  def show
    project = Project.find_by(id: params[:id])
    if project
      render json: project.tasks
    else
      render json: { message: "project not found" }
    end
  end

  def update
    project = Project.find(params[:id])
    if project
      if project.update_attributes(update_action_params)
        project.save
        render json: { project_object: project }
      else
        render json: { message: "something went wrong" }
      end
    else
      render json: { message: "project not found" }
    end
  end

  def destroy
    Project.find(params[:id]).destroy
  end

  private

  def create_action_params
    params.permit(:hash_id, :name, :description)
  end

  def update_action_params
    params.permit(:name, :description)
  end

end
