class OmniauthParser

  def initialize(omniauth)
    @omniauth = omniauth
  end
  
  def post_args
    @post_args ||= @omniauth['extra'].response.message.to_post_args
  end
  
  def email
    @email ||= post_args['openid.ext1.value.ext0']
  end

  def name
    @name ||= [ post_args['openid.ext1.value.ext2'], post_args['openid.ext1.value.ext3'] ].join(' ')
  end

  def identity
    @identity ||= post_args['openid.identity']
  end

  def user_hash
    { email: email, name: name, identity: identity }
  end
end
