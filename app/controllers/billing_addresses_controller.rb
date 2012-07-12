class BillingAddressesController < ApplicationController

  # POST /billing_addresses
  # POST /billing_addresses.json
  def create
    @billing_address = BillingAddress.new(params[:billing_address])
    respond_to do |format|
      if @billing_address.save
        format.json { render json: @billing_address, status: :created, location: @work_order }
      else
        format.json { render json: @billing_address.errors, status: :unprocessable_entity }
      end
    end
  end
end

