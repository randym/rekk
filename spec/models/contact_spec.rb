require 'spec_helper'
describe Contact do
  context 'factory' do
    subject { FactoryGirl.build(:contact) }
    it { should be_valid }
  end

  context 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:client) }
    it { FactoryGirl.create(:contact) 
         should validate_uniqueness_of(:email) }

  end

  context 'mass assignment' do 
    it { should allow_mass_assignment_of(:name) }
    it { should allow_mass_assignment_of(:email) }
    it { should allow_mass_assignment_of(:division) }
    it { should allow_mass_assignment_of(:phone) }
    it { should allow_mass_assignment_of(:client_id) }
    it { should allow_mass_assignment_of(:job_title) }
  end
end
