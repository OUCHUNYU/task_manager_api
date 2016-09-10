require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:chunyu)
  end

  test 'with a valid hash string should return all user projects' do
    get "/users/#{@user.hash_id}"
    user_json = JSON.parse(response.body)
    user_json.each do |project|
      assert_equal @user.id, project["user_id"]
    end
  end

  test 'with a invalid hash string should return error message' do
    get "/users/fsgfdfgdfsgs"
    error_message = JSON.parse(response.body)
    assert_equal "User not found", error_message['message']
  end

  test "create a user return a json with hash_id and projects" do
    post "/users"
    user_json = JSON.parse(response.body)
    assert user_json['hash_id']
    assert user_json['user_object']
    assert_not user_json['message']
  end

end
