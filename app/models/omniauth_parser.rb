class OmniauthParser

  def initialize(omniauth)
    @omniauth = omniauth.to_hash
  end
  
  def info
    @info ||= @omniauth["info"]
  end

  def email
    @email ||= info["email"]
  end

  def name
    @name ||= info["name"] 
  end

  def identity
    @identity ||= @omniauth["uid"]
  end

  def user_hash
    { email: email, name: name, identity: identity }
  end
end
