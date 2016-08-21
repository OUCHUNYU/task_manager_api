class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks


  def self.render_tasks_in_order(project)
    taskArr = project.tasks
    result = {
      open: [],
      in_progress: [],
      done: []
    }
    if project.open_task_order
      open_task_position_arr = project.open_task_order.split('')
      ordered_open_tasks = open_task_position_arr.map do |i|
        taskArr.find do |x|
          if x.id == i.to_i
            x
          end
        end
      end
      result[:open] = ordered_open_tasks
    end

    if project.in_progress_task_order
      in_progress_task_position_arr = project.in_progress_task_order.split('')
      ordered_in_progress_tasks = in_progress_task_position_arr.map do |i|
        taskArr.find do |x|
          if x.id == i.to_i
            x
          end
        end
      end
      result[:in_progress] = ordered_in_progress_tasks
    end

    if project.done_task_order
      done_task_position_arr = project.done_task_order.split('')
      ordered_done_tasks = done_task_position_arr.map do |i|
        taskArr.find do |x|
          if x.id == i.to_i
            x
          end
        end
      end
      result[:done] = ordered_done_tasks
    end

    return result

  end
end
