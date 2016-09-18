class User < ApplicationRecord
  has_many :projects, dependent: :destroy

  def self.render_projects_in_order(user)
    project_arr = user.projects
    if user.position_order
      position_arr = user.position_order.split(',')
      ordered_projects = position_arr.map do |i|
        project_arr.find do |x|
          if x.id == i.to_i
            x
          end
        end
      end
      ordered_projects.select {|project| project.archive == false}
    else
      return project_arr.select {|project| project.archive == false}
    end
  end

end
