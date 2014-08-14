require 'spec_helper'
require 'clear_db'

describe SongPresenter do
	before { clear_db }
	after { clear_db }
	
	it "should return url for id" do
		album = Album.create(:name => "Revolver")
		song = Song.create(:name => "Taxman", :album => album)
		presenter = SongPresenter.new(song)
		expect(presenter.id).to eq("/songs/#{song.id}")
	end
end  
