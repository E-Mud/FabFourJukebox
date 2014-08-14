require 'spec_helper'
require 'clear_db'

describe Listened do	
	before { clear_db }
	after  { clear_db }
	
	it "should be valid" do
		user = User.create(:email => "nexususer@gmail.com", :password => "123456")
		song = Song.create(:name => "Eleanor Rigby", :album => Album.create(:name =>"Revolver"))
		rel = Listened.create(:user => user, :song => song)
		expect(rel.valid?).to be true
	end
	
	it "should have been created today" do
		user = User.create(:email => "nexususer@gmail.com", :password => "123456")
		song = Song.create(:name => "Eleanor Rigby", :album => Album.create(:name =>"Revolver"))
		rel = Listened.create(:user => user, :song => song)
		expect(rel.listened_on).to eq(Date.today)
	end
end
