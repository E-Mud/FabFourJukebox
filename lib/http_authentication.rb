require 'base64'

module HttpAuthentication
	module Basic
		def authenticate_with_http_basic
			if auth_str = request.env['HTTP_AUTHORIZATION']
				credentials = Base64.decode64(auth_str.sub(/^Basic\s+/, '')).split ":"
				credentials unless credentials.nil? || credentials.size != 2
			end
		end

		def request_http_basic_authentication(realm = 'Application')
			response.headers["WWW-Authenticate"] = %(Basic realm="Application")
			response.body = "HTTP Basic: Access denied.\n"
			response.status = 401
		end
	end
end