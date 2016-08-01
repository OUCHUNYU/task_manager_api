require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  def setup
    @project = projects(:project1)
    @task    = tasks(:task1)
  end

  test 'a task blongs to a project' do
    assert_equal @project, @task.project
  end

  test 'a task has a title' do
    assert_equal 'test task', @task.title
  end
end
