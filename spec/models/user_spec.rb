require 'spec_helper'
require 'clear_db'

describe User do
	before { clear_db }
	after {clear_db }
	
	it "should expect an email" do
		user = User.create(:password => "123456")
		expect(user.valid?).to be false
	end
	
	it "should expect a password" do
		user = User.create(:email => "nexususer@gmail.com")
		expect(user.valid?).to be false
	end
	
	it "should expect a valid email" do
		user = User.create(:email => "nexususer", :password => "123456")
		expect(user.valid?).to be false
	end
	
	it "should expect an unique email" do
		user = User.create(:email => "nexususer@gmail.com", :password => "123456")
		expect(user.valid?).to be true
		user2 = User.create(:email => "nexususer@gmail.com", :password => "123456")
		expect(user2.valid?).to be false
	end
	
	it "should have been created today" do
		user = User.create(:email => "nexususer@gmail.com", :password => "123456")
		expect(user.created_on).to eq(Date.today)
	end
	
	it "should create a valid user" do
		user = User.create(:email => "nexususer@gmail.com", :password => "123456")
		expect(user.valid?).to be true
		user.save
		expect(user.saved?).to be true
	end
	
	it "should authenticate" do
		user = User.create(:email => "nexususer@gmail.com", :password => "123456")
		user.save
		expect(User.authenticate("nexususer@gmail.com", "123456").id).to eq(user.id)
	end
end
