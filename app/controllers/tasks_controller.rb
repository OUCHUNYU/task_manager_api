class TasksController < ApplicationController

  def create
    project = Project.find_by(id: create_action_params[:project_id])
    if project
      reconstructed_params = {
        title:        create_action_params[:title],
      }
      new_task = project.tasks.new(reconstructed_params)
      if new_task.valid?
        project.save
        if create_action_params[:list_id] == 1
          if project.open_task_order
            project.open_task_order += new_task.id.to_s + ","
          else
            project.open_task_order = new_task.id.to_s + ","
          end
        elsif create_action_params[:list_id] == 2
          if project.in_progress_task_order
            project.in_progress_task_order += new_task.id.to_s + ","
          else
            project.in_progress_task_order = new_task.id.to_s + ","
          end
        elsif create_action_params[:list_id] == 3
          if project.done_task_order
            project.done_task_order += new_task.id.to_s + ","
          else
            project.done_task_order = new_task.id.to_s + ","
          end
        end

        project.save
        task_groups = Project.render_tasks_in_order(project)
        render json: task_groups
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
      render json: task.project.tasks
    else
      render json: { message: "task not found" }
    end
  end

  def update
    task = Task.find_by(id: params[:id])
    if task
      if task.update_attributes(title: update_action_params[:task_title])
        # task.save
        puts task.title
        render json: task
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
    params.permit(:project_id, :title, :list_id)
  end

  def update_action_params
    params.permit(:task_title)
  end

end
