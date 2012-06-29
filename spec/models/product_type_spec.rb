describe ProductType do
  context 'factory' do
    subject { FactoryGirl.build(:product_type) }
    it { should be_valid}
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
  end

  context 'mass assignment' do 
    it { should allow_mass_assignment_of(:name) }
    it { should allow_mass_assignment_of(:expired) }
  end

  context 'classmethods' do
    context 'active' do
      it "returns product_types that are not marked as expired" do
        active = FactoryGirl.create(:product_type, name: Faker::Lorem.words.to_s, expired: false)
        FactoryGirl.create(:product_type, name: Faker::Lorem.words.to_s, expired: true)
        ProductType.active.size.should == 1
        ProductType.active.first.name.should == active.name
      end
    end
  end
end
