require 'spec_helper'
require 'clear_db'
require 'json'

describe 'AlbumTemplate' do
	before { clear_db }
	after {clear_db }
	
	it "should have the right name" do
		album = Album.create(:name => "Revolver")
		result = JSON.parse(Rabl::Renderer.json(album, 'album/album'))
		expect(result['name']).to eq(album.name)
	end

	it "should have the right songs" do
		album = Album.create(:name => "Revolver")
		Song.create(:name => "Taxman", :album => album).save
		Song.create(:name => "Eleanor Rigby", :album => album).save
		songs_names = album.songs.map {|song| song.name }
		album = AlbumPresenter.new(album, true)
		result = JSON.parse(Rabl::Renderer.json(album, 'album/album_full'))
		result['songs'].each do |song|
			expect(songs_names.include? song['name']).to be true
		end
	end

	it "list should have the right albums" do
		albums = []
		albums << Album.create(:name => "Revolver")
		albums << Album.create(:name => "Rubber Soul")
		albums_name = albums.map { |album| album.name }
		albums.map {|album| AlbumPresenter.new(album) }
		result = JSON.parse(Rabl::Renderer.json(albums, 'album/list_album'))
		albums.each do |album|
			expect(albums_name.include? album['name']).to be true
		end
	end
		
end   
