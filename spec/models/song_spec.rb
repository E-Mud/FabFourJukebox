require 'spec_helper'
require 'clear_db'

describe Song do
	before { clear_db }
	after {clear_db }
	
	it "should expect a name" do
		album = Album.create(:name => "Revolver")
		song = Song.create(:album => album)
		expect(song.valid?).to be false
	end
	
	it "should belong to an album" do
		song = Song.create(:name => "Penny Lane")
		expect(song.valid?).to be false
		
		album = Album.create(:name => "Revolver")
		album.songs << song
		expect(song.valid?).to be true
		
		album.save
		song.save
		song = Song.get(song.id)
		expect(song.album.id).to eq(album.id)
	end
end
