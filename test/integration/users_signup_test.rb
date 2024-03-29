require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: {
        user: { name:  "",
                email: "user@invalid",
                password:              "foo",
                password_confirmation: "bar"
        }
      }
    end
    assert_template 'users/new'
  end

  test "valid signup information" do
    get signup_path

    assert_difference 'User.count', 1 do
      post users_path, params: {
        user: { name:  "Test User",
                email: "user@example.com",
                password:              "passw0rd",
                password_confirmation: "passw0rd"
        }
      }
      follow_redirect!
    end
    assert_template 'users/show'
  end
end
