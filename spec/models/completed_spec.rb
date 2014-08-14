require 'spec_helper'
require 'clear_db'

describe Completed do	
	before { clear_db }
	after  { clear_db }
	
	it "should be valid" do
		user = User.create(:email => "nexususer@gmail.com", :password => "123456")
		album = Album.create(:name => "Revolver")
		rel = Completed.create(:user => user, :album => album)
		expect(rel.valid?).to be true
	end
	
	it "should have been created today" do
		user = User.create(:email => "nexususer@gmail.com", :password => "123456")
		album = Album.create(:name => "Revolver")
		rel = Completed.create(:user => user, :album => album)
		expect(rel.completed_on).to eq(Date.today)
	end
end