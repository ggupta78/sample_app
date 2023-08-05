require "test_helper"

class UsersSignup < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
  end
end

class UsersSignupTest < UsersSignup
  test 'invalid signup infomation' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: {
        user: {
          name: '',
          email: 'foomail',
          password: 'foo',
          password_confirmation: 'email'
        }
      }
    end
    assert_response :unprocessable_entity
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test 'valid signup information' do
    assert_difference 'User.count', 1 do
      post users_path, params: {
        user: {
          name: "Foo Bar",
          email: "foo@example.com",
          password: "password",
          password_confirmation: "password"
        }
      }
    end
    follow_redirect!
    # assert_template 'users/show'
    # assert is_logged_in?
  end

  test 'valid signup information with account activation' do
    assert_difference 'User.count', 1 do
      post users_path, params: {
        user: {
          name: 'Example User',
          email: 'user@example.com',
          password: 'password',
          password_confirmation: 'password'
        }
      }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
  end
end

class AccountActivationTest < UsersSignup
  def setup
    super
    post users_path, params: {
      user: {
        name: 'Example User',
        email: 'user@example.com',
        password: 'password',
        password_confirmation: 'password'
      }
    }
    @user = assigns(:user)
  end

  test 'should not be activated' do
    assert_not @user.activated?
  end

  test 'should not be able to login before account activation' do
    log_in_as(@user)
    assert_not is_logged_in?
  end

  test 'should not be able to login with invalid activation token' do
    get edit_account_activation_path("invalid token", email: @user.email)
    assert_not is_logged_in?
  end

  test 'should not be able to login with invalid email' do
    get edit_account_activation_path(@user.activation_token, email: "invalid email")
    assert_not is_logged_in?
  end

  test 'should login successfully with valid email and activation token' do
    get edit_account_activation_path(@user.activation_token, email: @user.email)
    assert @user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end

end
