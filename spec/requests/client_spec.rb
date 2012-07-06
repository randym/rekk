# encoding: UTF-8
require 'spec_helper'

describe 'Client' do 
  before do
    login_with_oauth
  end
  context 'on load' do
    before do
      @not_my_client = FactoryGirl.create(:client)
      @my_client = FactoryGirl.create(:client, user_id: user.id)
    end
    it 'lists only the current user clients by default' do
      visit '/clients'
      page.should have_link('alternate')
      page.should have_link(@my_client.name)
    end

    it 'lists all clients when you click the alternate link' do
      visit '/clients'
      click_link('alternate')
      page.should have_link(@not_my_client.name)
    end

    it 'shows a button for creating a new client' do
      visit '/clients'
      page.should have_link('new_item')
    end

    it 'renders the client/new page when the new_item button is clicked.' do
      visit '/clients'
      click_link('new_item')
      current_path.should == '/clients/new'
    end
  end

  context 'client/new', js: true do
    before do
      # new session as we swapped out the driver so login required.
      login_with_oauth
    end

    after(:each) do
      DatabaseCleaner.clean
    end

    context 'creating a client' do
      before(:each) do
        @client = FactoryGirl.build(:complete_client) 
        @contact = FactoryGirl.build(:complete_contact, client_id: @client.id) 
        visit '/clients/new'
        select user.name
        fill_in 'client_name',  with: @client.name
        fill_in 'client_local_name', with: @client.local_name
        fill_in 'client_accounting_code', with: @client.accounting_code
        fill_in 'client_memo', with: @client.memo
      end

      it 'creates a new client when the form is filled in and saved' do
        click_on 'save_client'
        current_path.should == '/clients'
        page.should have_content(@client.name)
      end

      context 'working with contacts' do
        before do
          page.execute_script("$('#add_contact').click()")
          # this is to give the bootstrap modal time to render 
          sleep 1 
          within('#add_contact_form') do
            fill_in 'name', with: @contact.name
            fill_in 'email', with: @contact.email
            fill_in 'job_title', with: @contact.job_title
            fill_in 'phone', with: @contact.phone
            fill_in 'division', with: @contact.division
          end
          find('#btn_save_contact').click
          # and again to let bootstrap modal get off the screen
          sleep 1
        end

        it 'renders the added contact' do
          page.should have_content(@contact.name)
        end

        it 'removes contacts when you click the remove-contact button' do
          find('.remove-contact').click
          page.should_not have_content(@contact.name)
        end

        it 'renders the edit form polulated with the contact data when you click the edit-contact button' do
          find('.edit-contact').click
          sleep 1
          within('#add_contact_form') do
            find_field('name').value.should == @contact.name 
            find_field('email').value.should == @contact.email
            find_field('job_title').value.should == @contact.job_title
            find_field('phone').value.should == @contact.phone
            find_field('division').value.should == @contact.division
          end
        end

        it 'properly passes the contact in with the client' do
          click_on 'save_client'
          click_on @client.name
          page.evaluate_script 'client.edit()'
          page.should have_content(@contact.job_title)
        end
      end
    end
  end
end
