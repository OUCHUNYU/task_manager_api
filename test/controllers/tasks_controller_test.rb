require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @task = tasks(:task1)
    @task2 = tasks(:task2)
    @task_arr = [@task, @task2]
    @user = users(:chunyu)
    @project = projects(:project1)
  end

  test 'a valid task will return' do
    get "/tasks/#{@task.id}"
    return_object = JSON.parse(response.body)
    return_object.each_with_index do |task, index|
      assert_equal @task_arr[index].title, task["title"]
    end
  end

  test 'a invalid task will return error message' do
    get "/tasks/sfdsafsdvjgsdj"
    return_object = JSON.parse(response.body)
    assert_equal "task not found", return_object["message"]
  end

  test 'create a task when project is valid' do
    assert_difference "Task.count", 1 do
      post "/tasks/", params: {
                                   project_id:     @project.id,
                                   title:        "good title"
                                 }
    end
    return_object = JSON.parse(response.body)
    return_object.each do |project|
      assert_equal "Array", project.class.to_s
    end
  end

  test 'can not create a task when project is invalid' do
    assert_difference "Task.count", 0 do
      post "/tasks/", params: {
                                   project:     @project.id,
                                   name:        "good title"
                                 }
    end

    return_object = JSON.parse(response.body)
    assert_equal "task not found", return_object["message"]
  end

  test 'update a task when found' do
    put "/tasks/#{@task.id}", params: {
                                        title:   "good title"
                                      }
    return_object = JSON.parse(response.body)

    updated_task = return_object.find {|task| task['id'] == @task.id}
    assert_equal "good title", updated_task['title']
  end

  test 'will not update a task when project not found' do
    put "/tasks/sfasdfsdf", params: {
                                        title:    "good title"
                                    }
    return_object = JSON.parse(response.body)
    assert_equal "task not found", return_object['message']
  end

  test 'delete when task found' do
    assert_difference "Task.count", -1 do
      delete "/tasks/#{@task.id}"
    end
  end

  test 'will not delete when task not found' do
    assert_difference "Task.count", 0 do
      delete "/tasks/sadfhkjs"
    end
  end
end
