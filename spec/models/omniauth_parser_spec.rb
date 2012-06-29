require 'spec_helper'
describe OmniauthParser do

  before :each do
    @omniauth_hash = {"provider"=>"google_apps",
                      "uid"=>"http://reallyenglish.com/openid?id=100232893175934414282",
                      "info"=>{"email"=>"randym@reallyenglish.com",
                               "first_name"=>"Randy",
                               "last_name"=>"Morgan",
                               "name"=>"Randy Morgan"},
                               "credentials"=>{},
                               "extra"=>{}}
    @parser = OmniauthParser.new(@omniauth_hash)
  end
  context 'instance methods' do
    context 'name' do
      it 'parses the name from omniauth response' do
        @parser.name.should == @omniauth_hash['info']['name']
      end
    end
    context 'email' do
      it 'parses the email from omniauth response' do
        @parser.email.should == @omniauth_hash['info']['email']
      end
    end
    context 'identity' do
      it 'parses the identity from omniauth response' do
        @parser.identity.should == @omniauth_hash['uid']
      end
    end
    context 'user_hash' do
      it 'returns a hash of email, name and identity' do
        @parser.user_hash.should == { email: @parser.email, name: @parser.name, identity: @parser.identity }
      end
    end
  end
end
