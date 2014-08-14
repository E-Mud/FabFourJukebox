require 'spec_helper'
require 'base64'

describe "UserController" do
	before do
		@users = []
		clear_db
		@users << User.create(:email => "nex@gmail.com", :password => "123456")
		@users << User.create(:email => "nexus@gmail.com", :password => "123456")
		@auth_str = "Basic " + Base64.encode64(@users[0].email + ":" + @users[0].password)
		@uri = Fabfourjukebox::App.url_for(:users, :index)
		@users.each { |user| user.save}
	end
	after {clear_db }
	
	def user_uri(id)
		Fabfourjukebox::App.url_for(:users, :index, :id => id)
	end
	
	it "should return users list" do
		users_emails = @users.map {|user| user.email}
		
		get @uri, {}, 'HTTP_AUTHORIZATION' => @auth_str
		
		expect(last_response.status).to eq(200)
		
		body = JSON.parse(last_response.body)
		expect(body.size).to eq(2)
		
		body.each do |user|
			expect(users_emails.include? user['email']).to be true
		end
	end
	
	it "should forbid wrong user" do
		get user_uri(user_id), {}, 'HTTP_AUTHORIZATION' => "Basic " + Base64.encode64("wrong_email@gmail.com" + ":" + "123456")
		expect(last_response.status).to eq(401)
	end
		
	
	it "should return right user" do
		user_id = @users[0].id
		user_email = @users[0].email
		uri = user_uri(user_id)
		
		get uri, {}, 'HTTP_AUTHORIZATION' => @auth_str
		
		expect(last_response.status).to eq(200)
		
		body = JSON.parse(last_response.body)
		expect(body['email']).to eq(user_email)
		expect(body['href']).to eq(uri)
	end
	
	it "should create a new user" do
		user_email = "nexo@gmail.com"
		new_user = {:email => user_email, :password => "123456"}
		
		post @uri, JSON.generate(new_user)
		
		expect(last_response.status).to eq(201)
	end
	
	it "should return a ref when creating" do
		user_email = "nexo@gmail.com"
		user_password = "123456"
		new_user = {:email => user_email, :password => user_password}
		
		post @uri, JSON.generate(new_user)
		
		get last_response.headers['Location'], {}, 'HTTP_AUTHORIZATION' => "Basic " + Base64.encode64(user_email + ":" + user_password)
		
		expect(last_response.status).to eq(200)
		
		body = JSON.parse(last_response.body)
		expect(body['email']).to eq(user_email)
		expect(body['created_on']).to eq(Date.today.to_s)
	end
	
	it "should raise an error over an used email" do
		user_email = @users[0].email
		new_user = {:email => user_email, :password => "123456"}
		
		post @uri, JSON.generate(new_user)
		
		expect(last_response.status).to eq(400)
		
		body = JSON.parse(last_response.body)
		expect(body['error'].nil?).to be false
		expect(body['error'].empty?).to be false
	end
end
