require 'spec_helper'

describe 'Home' do
  describe "Get /login" do
    it 'should redirect to login when the user is not logged in' do
      visit '/'
      current_path.should == "/login"
    end
    
    it 'should redirect to / when the user is already logged in' do
      login_with_oauth
      get '/login'
      puts current_url
      current_path.should == "/"
    end
     
  end
end
