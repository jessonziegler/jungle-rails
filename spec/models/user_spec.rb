require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it 'should create a new user if all the fields are present' do
      @user = User.new(
        name: 'test',
        email: 'test@gmail.com',
        password: 'testjungleruby',
        password_confirmation: 'testjungleruby',
      )
      expect(@user.valid?).to be(true)
    end
    it 'should not create a new user if the first name is not present' do
      @user = User.new(
        name: nil,
        email: 'test@gmail.com',
        password: 'testjungleruby',
        password_confirmation: 'testjungleruby',
      )
      expect(@user.valid?).to be(false)
      expect(@user.errors[:name]).to include("can't be blank")
    end

    it 'should not create a new user if the email is not present' do
      @user = User.new(
        name: 'test',
        email: nil,
        password: 'testjungleruby',
        password_confirmation: 'testjungleruby',
      )
      expect(@user.valid?).to be(false)
      expect(@user.errors[:email]).to include("can't be blank")
    end

    it 'should not create a new user if the password is not present' do
      @user = User.new(
        name: 'test',
        email: 'test@gmail.com',
        password: nil,
        password_confirmation: 'testjungleruby',
      )
      expect(@user.valid?).to be(false)
      expect(@user.errors[:password]).to include("can't be blank")
    end

    it 'should not create a new user if the password confirmation is not present' do
      @user = User.new(
        name: 'test',
        email: 'test@gmail.com',
        password: 'testjungleruby',
        password_confirmation: nil
      )
      expect(@user.valid?).to be(false)
      expect(@user.errors[:password_confirmation]).to include("can't be blank")
    end

    it 'should not create a new user if the password confirmation does not match the password' do
      @user = User.new(
        name: 'test',
        email: 'test@gmail.com',
        password: 'testjungleruby',
        password_confirmation: 'testjungleruby1',
      )
      expect(@user.valid?).to be(false)
      expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it 'should not create a new user if the email is a duplicate' do
      @user = User.new(
        name: 'test',
        email: 'test@gmail.com',
        password: 'testjungleruby',
        password_confirmation: 'testjungleruby',
      )
      @user.save
      @user_duplicate = User.new(
        name: 'test',
        email: 'test@gmail.com',
        password: 'testjungleruby1',
        password_confirmation: 'testjungleruby1',
      )
      expect(@user_duplicate.valid?).to be(false)
      expect(@user_duplicate.errors.full_messages).to include("Email has already been taken")
    end
    it 'should not create a new user if the password is less than 10 characters long' do
      @user = User.new(
        name: 'test',
        email: 'test@gmail.com',
        password: 'test',
        password_confirmation: 'test',
      )
      expect(@user.valid?).to be(false)
      expect(@user.errors.full_messages[0]).to include("Password is too short")
    end

    describe '.authenticate_with_credentials' do

      it 'should log the user in if they are registered and the password is correct' do
        @user = User.new(
          name: 'test',
          email: 'test@gmail.com',
          password: 'testjungleruby',
          password_confirmation: 'testjungleruby'
        )
        @user.save!
        expect(User.authenticate_with_credentials('test@gmail.com', 'testjungleruby')).to be_truthy
      end
      it 'should not log the user in if the password is incorrect' do
        @user = User.new(
          name: 'test',
          email: 'test@gmail.com',
          password: 'testjungleruby',
          password_confirmation: 'testjungleruby'
        )
        @user.save!
        expect(User.authenticate_with_credentials('test@gmail.com', 'wrong')).to be(nil)
      end
      it 'should log the user in if the email includes spaces before or after' do
        @user = User.new(
          name: 'test',
          email: 'test@gmail.com',
          password: 'testjungleruby',
          password_confirmation: 'testjungleruby'
        )
        @user.save!
        expect(User.authenticate_with_credentials(' test@gmail.com ', 'testjungleruby')).to be_truthy
      end

      it 'should log the user in if the email includes incorrectly cased characters' do
        @user = User.new(
          name: 'test',
          email: 'test@gmail.com',
          password: 'testjungleruby',
          password_confirmation: 'testjungleruby'
        )
        @user.save!
        expect(User.authenticate_with_credentials('TEST@gmail.com', 'testjungleruby')).to be_truthy
      end
    end
  end
end