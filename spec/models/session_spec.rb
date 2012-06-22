require 'spec_helper'
describe Session do
  before(:each) do 
    session = Session.new
    session.session_id = 'foo'
    session.created_at = (24.hours + 1.minute).ago
    session.save
  end

  describe 'expire_sessions' do
    it 'removes all sessions from the db' do
      Session.all().should have(1).item

      Session.expire_sessions
      Session.all().should have(0).items
    end
  end
end
