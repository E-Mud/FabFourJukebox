require 'spec_helper'
require 'clear_db'

describe UserPresenter do
	before { clear_db }
	after { clear_db }
	
	it "should return url for id" do
		user = User.create(:email => "nexususer@gmail.com", :password => "123456")
		presenter = UserPresenter.new(user)
		expect(presenter.id).to eq("/users/#{user.id}")
	end
	
	it "should have the right songs" do
		user = User.create(:email => "nexususer@gmail.com", :password => "123456")
		album = Album.create(:name =>"Revolver")
		songs = []
		songs << Song.create(:name => "Eleanor Rigby", :album => album)
		songs << Song.create(:name => "Taxman", :album => album)
		Listened.create(:user => user, :song => songs[0])
		Listened.create(:user => user, :song => songs[1])
		
		result = UserPresenter.new(user, true)
		result.songs.each.with_index do |song, i|
			expect(song.name).to eq(songs[i].name)
			expect(song.listened_on).to eq(Date.today)
		end
	end
end 
