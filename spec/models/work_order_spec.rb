require 'spec_helper'

describe WorkOrder do
  context 'factory' do
    subject { FactoryGirl.build(:work_order) }
    it { should be_valid }

  end
  context 'validations' do
    it { should validate_presence_of(:client_id) }
    it { should validate_presence_of(:owner_id) }
    it { should validate_presence_of(:author_id) }
    it { should validate_presence_of(:payment_type_id) }
  end

  context 'mass_assignemnt' do
    [:author_id, :owner_id, :client_id, :payment_type_id, :memo].each do |attribute|
     it { should allow_mass_assignment_of(attribute) }
    end
  end

  # classmethods
  context 'classmethods' do
    before(:each) do
      @work_order = FactoryGirl.create(:work_order)
    end
    
    it 'returns work orders by author' do
      WorkOrder.by_author(@work_order.author).first.should == @work_order
      WorkOrder.by_author(@work_order.author).first.author.should == @work_order.author
    end 
    
    it 'returns work orders by owner' do
      WorkOrder.by_owner(@work_order.owner).first.should == @work_order
      WorkOrder.by_owner(@work_order.owner).first.owner.should == @work_order.owner
    end
    it 'returns work orders by client' do
      WorkOrder.by_client(@work_order.client).first.should == @work_order
      WorkOrder.by_client(@work_order.client).first.client.should == @work_order.client
    end

  end

end
