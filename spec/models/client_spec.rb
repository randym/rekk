require 'spec_helper'
describe Client do
  context "factory" do
    subject { FactoryGirl.build(:client) }
    it { should be_valid }
  end

  context 'validataions' do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:name) }
    it { FactoryGirl.create(:client)
         should validate_uniqueness_of(:name) }
  end

  context 'mass assignment' do
    it { should allow_mass_assignment_of(:name) }
    it { should allow_mass_assignment_of(:local_name) }
    it { should allow_mass_assignment_of(:accounting_code) }
    it { should allow_mass_assignment_of(:contacts_attributes) }
    it { should allow_mass_assignment_of(:memo) }
    it { should allow_mass_assignment_of(:user_id) }
    it { should allow_mass_assignment_of(:billing_addresses_attributes) }
  end

  context 'nested_attributes' do
    it { should accept_nested_attributes_for(:billing_addresses) }
    it { should accept_nested_attributes_for(:contacts) }
  end
  context 'classmethods' do
    context "by_user" do
      it "returns specific user's clients" do
        user_a = FactoryGirl.create(:user, email: Faker::Internet.email('foo'))
        user_b = FactoryGirl.create(:user, email: Faker::Internet.email('bar'))
        FactoryGirl.create(:client, name: 'user_a client', user: user_a)
        user_b_client = FactoryGirl.create(:client, name: 'user_b client', user: user_b)
        user_clients = Client.by_user(user_b)
        user_clients.size.should == 1
        user_clients.first.user.should == user_b
      end
    end
  end
end
