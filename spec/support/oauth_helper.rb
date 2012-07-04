module OauthHelper
  def user
  end

  def login_with_oauth(user = nil)
    @user ||= FactoryGirl.create(:user)
    OmniAuth.config.add_mock(:google_apps, uid: 'aaaa',
                             provider: 'google_apps',
                             info: {
                               email: @user.email,
                               name: @user.name,
                               identity: @user.identity
                             })
                             visit '/auth/google_apps'
  end

end
