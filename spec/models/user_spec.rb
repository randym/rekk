require 'spec_helper'

describe User do
  context 'factory' do
    subject { FactoryGirl.build(:user) }
    it { should be_valid }
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:identity) }
    it { FactoryGirl.create(:user)
         should validate_uniqueness_of(:email) }
  end

  context 'mass assignement' do
    it { should allow_mass_assignment_of(:name) }
    it { should allow_mass_assignment_of(:email) }
    it { should allow_mass_assignment_of(:identity) }
  end 
  describe 'classmethods' do
    before(:each) do
      @omniauth_hash = {"provider"=>"google_apps",
                        "uid"=>"http://reallyenglish.com/openid?id=100232893175934414282",
                        "info"=>{"email"=>"randym@reallyenglish.com",
                                 "first_name"=>"Randy",
                                 "last_name"=>"Morgan",
                                 "name"=>"Randy Morgan"},
                                 "credentials"=>{},
                                 "extra"=>{}}
    end

    describe 'authenticate' do
      context 'with an unknown user' do
        before do 
          @user = User.authenticate(@omniauth_hash) 
        end

        it 'creates a new user' do
          User.all().should have(1).item
        end

        it 'sets the email' do
          @user.email.should == @omniauth_hash["info"]["email"]
        end

        it 'sets the name' do
          @user.name.should == @omniauth_hash["info"]["name"]
        end

        it 'sets the identity' do 
          @user.identity.should == @omniauth_hash["uid"]
        end
      end 

      context 'with a known user' do
        before do
          FactoryGirl.create(:user, :email => @omniauth_hash["info"]["email"], 
                             :name => @omniauth_hash["info"]["name"],
                             :identity => @omniauth_hash["uid"])
          @omniauth_hash['info']['name'] = "fundantastic"
          @omniauth_hash['uid'] = 'wasssat?'

          @user = User.authenticate(@omniauth_hash)
        end

        it 'loads an existing user' do
          User.all().should have(1).item
        end

        it 'updates the name' do
          @omniauth_hash['info']['name'].should == 'fundantastic'
          @user.name.should == @omniauth_hash['info']['name']
        end

        it 'updates the identity' do 
          @omniauth_hash['uid'].should == 'wasssat?'
          @user.identity.should == @omniauth_hash['uid']
        end
      end
    end
  end
end
