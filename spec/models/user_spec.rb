require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  
  describe 'Validations' do
    it 'is created with matching password and password_confirmation fields' do
      @user = User.new(
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'Test',
        last_name: 'User',
        name: 'Test User'
      )
      expect(@user).to be_valid
    end

    it 'validates the presence of the password and the password_confirmation' do
      @user = User.new(email: 'test@test.com')
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Password can't be blank", "Password is too short (minimum is 6 characters)")
    end

    it 'validates that password and password_confirmation match' do
      @user = User.new(
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'other_password'
      )
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'validates the uniqueness of emails (case-insensitive)' do
      User.create(
        email: 'test@test.com', 
        password: 'password', 
        password_confirmation: 'password',
        first_name: 'Test',
        last_name: 'User',
        name: 'Test User'
        )
      @user = User.new(
        email: 'TEST@TEST.com',
        password: 'other_password',
        password_confirmation: 'other_password',
        first_name: 'Other',
        last_name: 'User',
        name: 'Other User'
      )
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Email has already been taken")
    end

    it 'validates the presence of email, first name, and last name' do
      @user = User.new
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Email can't be blank", "First name can't be blank", "Last name can't be blank")
    end

    it 'validates that password has a minimum length' do
      @user = User.new(
        email: 'test@test.com',
        password: 'short',
        password_confirmation: 'short'
      )
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end
  
  describe '.authenticate_with_credentials' do
    it 'authenticates with valid credentials' do
      @user = User.create(
        email: 'test@test.com', 
        password: 'password', 
        password_confirmation: 'password',
        first_name: 'Test',
        last_name: 'User',
        name: 'Test User'
        )
      @authenticated_user = User.authenticate_with_credentials('test@test.com', 'password')
      expect(@authenticated_user).to eq(@user)
    end

    it 'does not authenticate with an invalid email' do
      @user = User.create(
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'Test',
        last_name: 'User',
        name: 'Test User'
      )
      @authenticated_user = User.authenticate_with_credentials('wrong_email@test.com', 'password')
      expect(@authenticated_user).to be_nil
    end

    it 'does not authenticate with an invalid password' do
     @user = User.create(
      email: 'test@test.com',
      password: 'password',
      password_confirmation: 'password',
      first_name: 'Test',
      last_name: 'User',
      name: 'Test User'
     )
      @authenticated_user = User.authenticate_with_credentials('test@test.com', 'wrong_password')
      expect(@authenticated_user).to be_nil
    end

    it 'authenticates with email containing spaces' do
      @user = User.create(
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'Test',
        last_name: 'User',
        name: 'Test User'
        )
      @authenticated_user = User.authenticate_with_credentials(' test@test.com ', 'password')
      expect(@authenticated_user).to eq(@user)
    end
    
    it 'authenticates with email in different case' do
      @user = User.create(
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'Test',
        last_name: 'User',
        name: 'Test User'
      )
      @authenticated_user = User.authenticate_with_credentials('TEST@TEST.COM', 'password')
      expect(@authenticated_user).to eq(@user)
    end
     
  end

end
