require 'spec_helper'

describe "AlbumController" do
	before do
		@albums = []
		clear_db
		@albums << Album.create(:name => "Revolver")
		@albums << Album.create(:name => "Rubber Soul")
		@albums.each { |album| album.save}
	end
	after {clear_db }

	
	it "should return albums list" do
		albums_names = @albums.map {|album| album.name}
		get '/albums'
		expect(last_response.status).to eq(200)
		body = JSON.parse(last_response.body)
		expect(body.size).to eq(2)
		body.each do |album|
			expect(albums_names.include? album['name']).to be true
		end
	end
	
	it "should return right album" do
		album_id = @albums[0].id
		album_name = @albums[0].name
		get "/albums/#{album_id}"
		expect(last_response.status).to eq(200)
		body = JSON.parse(last_response.body)
		expect(body['name']).to eq(album_name)
	end
	
	it "should return 404 on wrong id" do
		album_id = -1
		get "/albums/#{album_id}"
		expect(last_response.status).to eq(404)
	end
end 
