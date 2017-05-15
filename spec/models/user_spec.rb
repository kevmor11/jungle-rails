require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    before(:each) do
      @user = User.new(name: 'name', email: 'email@email.com', password: 'password', password_confirmation: 'password')
    end  

    it 'should check if the user is created' do
      expect(@user).to be_valid
    end  

    it 'should not create a user without matching password and password_confirmation' do
      @user.password_confirmation = 'not password'
      expect(@user.valid?).to be false
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should not create a user with a name that is nil' do
      @user.name = nil
      expect(@user.valid?).to be false
      expect(@user.errors.full_messages).to include("Name can't be blank")    
    end

    it 'should not create a user with an email that is nil' do
      @user.email = nil
      expect(@user.valid?).to be false
      expect(@user.errors.full_messages).to include("Email can't be blank")    
    end

    it 'should not create a user with a password that is nil' do
      @user.password = nil
      expect(@user.valid?).to be false
      expect(@user.errors.full_messages).to include("Password can't be blank")    
    end

    it 'should not create a user with a password confirmation that is nil' do
      @user.password_confirmation = nil
      expect(@user.valid?).to be false
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")    
    end

    it 'should not create two users with the same email' do
      @user.save
      @user2 = User.new(name: 'name2', email: 'EMAIL@EMAIL.com', password: 'password2', password_confirmation: 'password2')
      expect(@user2.valid?).to be false
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end


    it 'should not create a user with a password less than 8 characters' do
      @user.password = 'passwor'
      @user.password_confirmation = 'passwor'
      expect(@user.valid?).to be false
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")    
    end

  end

  describe '.authenticate_with_credentials' do
 
    before(:each) do
      @user = User.create!(name: 'name', email: 'email@email.com', password: 'password', password_confirmation: 'password')
    end  

    it 'should return the authenticated user if the credentials match' do
      expect(User.authenticate_with_credentials('email@email.com', 'password')).to eq(@user)
    end

    it 'should not return the authenticated user if the credentials do not match' do
      @user.password = 'not password'
      @user.password_confirmation = 'not password'
      expect(User.authenticate_with_credentials('email@email.com', 'not password')).to_not eq(@user)
    end

    it 'should return the authenticated user even if the email is followed by space(s)' do
      @user.email = ' email@email.com '
      expect(User.authenticate_with_credentials(' email@email.com ', 'password')).to eq(@user)      
    end

    it 'should return the authenticated user even if the email contains uppercase characters' do
      @user.email = 'Email@eMail.COM'
      expect(User.authenticate_with_credentials('Email@eMail.COM', 'password')).to eq(@user)      
    end

  end

end
