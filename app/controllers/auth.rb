Fabfourjukebox::App.controllers :auth do
  include HttpAuthentication::Basic

  error 401 do
  	request_http_basic_authentication
  end

  get :index do
  	credentials = authenticate_with_http_basic
  	if(!credentials.nil? && !User.authenticate(credentials[0], credentials[1]).nil?)
  		status 200
  	else
  		status 401
  	end
  end
end 
