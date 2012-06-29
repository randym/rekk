require 'spec_helper'
describe Product do
  context 'factory' do
    subject { FactoryGirl.build(:product) }
    it { should be_valid }
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:price) }
  end

  context 'mass assignment' do 
    it { should allow_mass_assignment_of(:name) }
    it { should allow_mass_assignment_of(:price) }
    it { should allow_mass_assignment_of(:includes_tax) }
    it { should allow_mass_assignment_of(:product_type_id) }
    it { should allow_mass_assignment_of(:expired) }
  end

  context 'classmethods' do
    context 'active' do
      it "returns products that are not marked as expired" do
        active = FactoryGirl.create(:product, name: Faker::Lorem.words.to_s, expired: false)
        FactoryGirl.create(:product, name: Faker::Lorem.words.to_s, expired: true)
        Product.active.size.should == 1
        Product.active.first.name.should == active.name
      end
    end
  end
end
