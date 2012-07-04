require 'spec_helper'

describe WorkOrder do
  context "factory" do
    subject { FactoryGirl.build(:work_order) }
    it { should be_valid }
  end
end
