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

  test 'create a project when user is valid' do
    assert_difference "Project.count", 1 do
      post "/projects/", params: {
                                   hash_id:     @user.hash_id,
                                   name:        "good name",
                                   description: "good description too"
                                 }
    end

    return_object = JSON.parse(response.body)
    return_object.each do |project|
      assert_equal @user.id, project['user_id']
    end
  end

  test 'can not create a project when user is invalid' do
    assert_difference "Project.count", 0 do
      post "/projects/", params: {
                                   hash_id:     "some thing invalid",
                                   name:        "good name",
                                   description: "good description too"
                                 }
    end

    return_object = JSON.parse(response.body)
    assert_equal "user not found", return_object["message"]
  end


end
