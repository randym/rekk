require 'spec_helper'

describe "WorkOrders" do

  describe "GET /work_orders" do
    before(:each) do 
      login_with_oauth
    end
    it "works! (now write some real specs)" do
      login_with_oauth
      visit '/work_orders'
      response.status.should be(200)
    end
  end
end
