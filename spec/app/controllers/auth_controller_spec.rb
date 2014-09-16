require 'spec_helper'
require 'base64'

describe  "AuthController" do
	before do
		clear_db
		@user = User.create(:email => "nex@gmail.com", :password => "123456")
		@user.save
	end

	after do
		clear_db
	end

	def auth_uri
		Fabfourjukebox::App.url_for(:auth, :index)
	end

	def basic_auth(email, psswd)
		"Basic " + Base64.encode64(email + ":" + psswd)
	end

	it "should return a 401 for a wrong auth" do
		get auth_uri, {}, 'HTTP_AUTHORIZATION' => basic_auth("wrong_email@gmail.com", "123456")

		expect(last_response.status).to eq(401)
	end

	it "should return a 200 for a right user" do
		get auth_uri, {}, 'HTTP_AUTHORIZATION' => basic_auth(@user.email, @user.password)

		expect(last_response.status).to eq(200)
	end
end
