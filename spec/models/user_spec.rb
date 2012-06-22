require 'spec_helper'

describe User do
  describe 'authentication' do 
    before(:each) do
      OmniauthParser.any_instance.stub(:email).and_return('test@example.com')
      OmniauthParser.any_instance.stub(:name).and_return('Test User')
      OmniauthParser.any_instance.stub(:identity).and_return('the secret identity')
    end

    context 'with an unknown user' do
      before(:each) do 
        @user = User.authenticate('') 
      end

      it 'creates a new user' do
        User.all().should have(1).item
      end
      
      it 'sets the email' do
        @user.email.should == 'test@example.com'
      end
      
      it 'sets the name' do
        @user.name.should == 'Test User'
      end

      it 'sets the identity' do 
        @user.identity.should == 'the secret identity'
      end
    end 

    context 'with a known user' do
      before do
        user = User.new(:email => 'test@example.com', :name => 'Old Name', :identity => 'the old secret identity')
        user.save
        @user = User.authenticate('')
      end
      it 'loads an existing user' do
        User.all().should have(1).item
      end

      it 'updates the name' do
        @user.name.should == 'Test User'
      end

      it 'updates the identity' do 
        @user.identity.should == 'the secret identity'
      end
    end
  end
end
