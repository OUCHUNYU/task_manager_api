require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:chunyu)
    @project = projects(:project1)
  end

  test 'a valid project will return all tasks' do
    get "/projects/#{@project.id}"
    puts return_object = JSON.parse(response.body)
    return_object.each do |project|
      assert_equal "Array", project.class.to_s
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

  test 'update a project when found' do
    put "/projects/#{@project.id}", params: {
                                               name:        "good name",
                                               description: "good description too"
                                             }
    return_object = JSON.parse(response.body)

    updated_project = return_object.find {|pro| pro['id'] == @project.id}

    assert_equal "good name", updated_project['name']
    assert_equal "good description too", updated_project['description']
  end

  test 'will not update a project when project not found' do
    put "/projects/sfasdfsdf", params: {
                                         name:        "good name",
                                         description: "good description too"
                                       }
    return_object = JSON.parse(response.body)
    assert_equal "project not found", return_object['message']
  end

  test 'delete when project found' do
    assert_difference "Project.count", -1 do
      delete "/projects/#{@project.id}", params: {
                                                    hash_id: @user.hash_id,
                                                    id: @project.id,
                                                    position_order: "fsfdfsdfadf"
                                                 }
    end
  end

  test 'will not delete when project not found' do
    assert_difference "Project.count", 0 do
      delete "/projects/sadfhkjs"
    end
  end

end
