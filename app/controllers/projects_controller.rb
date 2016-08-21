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
        if user.position_order
          user.position_order += new_project.id.to_s
          # new_order = user.position_order + new_project.id
          # user.update_attributes(position_order: new_order)
        else
          user.position_order = new_project.id.to_s
        end
        user.save

        project_arr = User.render_projects_in_order(user)
        render json: project_arr
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
      task_groups = Project.render_tasks_in_order(project)
      render json: task_groups
    else
      render json: { message: "project not found" }
    end
  end

  def update
    project = Project.find_by(id: params[:id])
    if project
      if project.update_attributes(update_action_params)
        project.save
        render json: project.user.projects
      else
        render json: { message: "something went wrong" }
      end
    else
      render json: { message: "project not found" }
    end
  end

  def destroy
    project = Project.find_by(id: params[:id])
    project.destroy if project
  end

  private

  def create_action_params
    params.permit(:hash_id, :name, :description)
  end

  def update_action_params
    params.permit(:name, :description)
  end

end
