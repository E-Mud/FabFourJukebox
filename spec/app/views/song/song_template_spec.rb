require 'spec_helper'
require 'clear_db'
require 'json'

describe 'SongTemplate' do
	before { clear_db }
	after {clear_db }
	
	it "should have the right name" do
		album = Album.create(:name => "Revolver")
		song = Song.create(:name => "Taxman", :album => album)
		result = JSON.parse(Rabl::Renderer.json(song, 'song/song'))
		expect(result['name']).to eq(song.name)
	end

	it "list should have the right songs" do
		album = Album.create(:name => "Revolver")
		Song.create(:name => "Taxman", :album => album).save
		Song.create(:name => "Eleanor Rigby", :album => album).save
		songs = Song.all.map {|song| SongPresenter.new(song) }
		songs_names = songs.map {|song| song.name }
		result = JSON.parse(Rabl::Renderer.json(songs, 'song/list_song'))
		result.each do |song|
			expect(songs_names.include? song['name']).to be true
		end
	end
	
	it "should have the album" do
		album = Album.create(:name => "Revolver")
		song = SongPresenter.new(Song.create(:name => "Taxman", :album => album), true)
		result = JSON.parse(Rabl::Renderer.json(song, 'song/song_full'))
		expect(result['album']['name']).to eq(album.name)
	end
		
end  
