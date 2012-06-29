require 'spec_helper'
describe Session do
  before(:each) do 
    session = Session.new()
    session.session_id = 'foo'
    session.created_at = (24.hours + 1.minute).ago
    session.save

    session = Session.new()
    session.session_id = 'bar'
    session.created_at = 24.hours.ago
    session.save
  end

  context 'classmethods' do
    context 'expire_sessions' do
      before(:each) do
        Session.expire_sessions
      end
      it 'removes all sessions more than a day old from the db' do
        Session.find_by_session_id('foo').should be_nil
      end

      it 'does not remove sessions that are not more than a day old' do
        Session.first.session_id.should == 'bar'
      end
    end
  end
end
