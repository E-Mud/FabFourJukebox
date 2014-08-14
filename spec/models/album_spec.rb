require 'spec_helper'
require 'clear_db'

describe Album do
	before { clear_db }
	after { clear_db }
	
	it "should expect a name" do
		album = Album.create
		expect(album.valid?).to be false
	end
	
	it "should have added songs" do
		album = Album.create(:name => "Revolver")
		ids = []
		songs = []
		
		songs << Song.create(:name => "Eleanor Rigby")
		songs << Song.create(:name => "Taxman")
		
		songs.each do |song|
			album.songs << song
			song.save
			ids << song.id
		end
		
		album.save
		album = Album.get(album.id)
		
		album.songs.each do |sn|
			expect(ids.include? sn.id).to be true
		end
	end
end 
