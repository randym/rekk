require 'spec_helper'

describe 'Home' do
  describe "Get /login" do
    
    context 'with an unknown user' do
      it 'should redirect to login when the user is not logged in' do
        visit '/'
        current_path.should == "/login"
      end
    end

    context 'with a loged in user' do
      it 'should redirect to / when /login is accessed' do
        login_with_oauth
        get '/login'
        current_path.should == "/"
      end
    end
    context 'via the login link' do
      it 'should log the user in!' do
        visit '/login'
        click_link('login')
        current_path.should == "/"
      end
    end

    it 'should show the user name in the page' do
      login_with_oauth
      visit '/'
      page.should have_content(user.name)
    end
  end
end
