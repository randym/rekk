class SessionsController < ApplicationController
  def create
    openid = request.env['omniauth.auth']['extra'].response.message.to_post_args
    # http://rubydoc.info/gems/ruby-openid/2.1.8/OpenID/Message
    #
    # {"openid.ns"=>"http://specs.openid.net/auth/2.0", 
    #  "openid.ns.ext1"=>"http://openid.net/srv/ax/1.0", 
    #  "openid.ns.sreg"=>"http://openid.net/extensions/sreg/1.1", 
    #  "_method"=>"post", 
    #  "openid.mode"=>"id_res", 
    #  "openid.op_endpoint"=>"https://www.google.com/a/reallyenglish.com/o8/ud?be=o8", 
    #  "openid.response_nonce"=>"2012-06-20T13:57:22Z-LGfdNrgVDvT2g", 
    #  "openid.return_to"=>"http://0.0.0.0:5000/auth/google_apps/callback?_method=post", 
    #  "openid.assoc_handle"=>"AMlYA9Xih35xPNiXqr48l-G_IwMMEvhNa4DY3lI4V7AeJ2RIE2zMpgSJ", 
    #  "openid.signed"=>"op_endpoint,claimed_id,identity,return_to,response_nonce,assoc_handle,ns.ext1,ext1.mode,ext1.type.ext2,ext1.value.ext2,ext1.type.ext0,ext1.value.ext0,ext1.type.ext3,ext1.value.ext3", 
    #  "openid.sig"=>"19f4ww9sBuC5EbfRRwzjenASe7U=", 
    #  "openid.identity"=>"http://reallyenglish.com/openid?id=100232893175934414282", 
    #  "openid.claimed_id"=>"http://reallyenglish.com/openid?id=100232893175934414282", 
    #  "openid.ext1.mode"=>"fetch_response", 
    #  "openid.ext1.type.ext2"=>"http://axschema.org/namePerson/first", 
    #  "openid.ext1.value.ext2"=>"Randy", 
    #  "openid.ext1.type.ext0"=>"http://axschema.org/contact/email", 
    #  "openid.ext1.value.ext0"=>"randym@reallyenglish.com", 
    #  "openid.ext1.type.ext3"=>"http://axschema.org/namePerson/last", 
    #  "openid.ext1.value.ext3"=>"Morgan"}

    user_attr = { email: openid['openid.ext1.value.ext0'],
                  name: "#{openid['openid.ext1.value.ext2']} #{openid['ext1.value.ext3']}", 
                  auth_hash: openid['openid.identity'] }

    user = User.find_or_create_by_email(user_attr[:email])
    user.update_attributes(user_attr)
    session[:user_id] = user.id
    redirect_to '/'
  end

end
