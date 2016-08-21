class TasksController < ApplicationController

  def create
    project = Project.find_by(project_id: params[:project_id])
    if project
      reconstructed_params = {
        title:        create_action_params[:title],
      }
      new_task = user.tasks.new(reconstructed_params)
      if new_task.valid?
        project.save
        render json: project.tasks
      else
        render json: { message: "something went wrong" }
      end
    else
        render json: { message: "task not found" }
    end
  end

  def show
    task = Task.find_by(id: params[:id])
    if task
      render json: project.tasks
    else
      render json: { message: "task not found" }
    end
  end

  def update
    task = Task.find_by(id: params[:id])
    if task
      if task.update_attributes(update_action_params)
        task.save
        render json: task.project.tasks
      else
        render json: { message: "something went wrong" }
      end
    else
      render json: { message: "task not found" }
    end
  end

  def destroy
    task = Task.find_by(id: params[:id])
    task.destroy if task
  end

  private

  def create_action_params
    params.permit(:project_id, :title)
  end

  def update_action_params
    params.permit(:title)
  end

end
