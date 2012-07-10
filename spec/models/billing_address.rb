require 'spec_helper'
describe BillingAddress do
  context 'factory' do
    subject { FactoryGirl.build(:billing_address) }
    it { should be_valid }
  end

  context 'validataions' do
    it { should validate_presence_of(:postal_code) }
    it { should validate_presence_of(:client_id) }
    it { should validate_presence_of(:company_name) }
  end

  context 'mass assignment' do
    it { should allow_mass_assignment_of(:postal_code) }
    it { should allow_mass_assignment_of(:address_1) }
    it { should allow_mass_assignment_of(:address_2) }
    it { should allow_mass_assignment_of(:address_3) }
    it { should allow_mass_assignment_of(:company_name) }
    it { should allow_mass_assignment_of(:recipient_name) }
    it { should allow_mass_assignment_of(:recipient_title) }
    it { should allow_mass_assignment_of(:client_id) }

  end
end
