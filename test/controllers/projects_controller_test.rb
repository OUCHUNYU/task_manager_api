require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:chunyu)
    @project = projects(:project1)
  end

  test 'a valid project will return all tasks' do
    get "/projects/#{@project.id}"
    return_object = JSON.parse(response.body)
    return_object.each do |task|
      assert_equal @project.id, task["project_id"]
    end
  end

  test 'a invalid project will return error message' do
    get "/projects/sfdsafsdvjgsdj"
    return_object = JSON.parse(response.body)
    assert_equal "project not found", return_object["message"]
  end
end
