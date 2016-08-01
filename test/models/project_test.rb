require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  def setup
    @project = projects(:project1)
    @user    = users(:chunyu)
  end

  test 'a project blongs to a user' do
    assert_equal @user, @project.user
  end

  test 'a project has many tasks' do
    assert @project.tasks
  end

  test 'a project has a name' do
    assert_equal 'test project', @project.name
  end

  test 'a project has a description' do
    assert_equal 'test description', @project.description
  end

end
