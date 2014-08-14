require 'spec_helper'

describe "SongController" do
	before do
		@songs = []
		clear_db
		@album = Album.create(:name => "Revolver")
		@songs << Song.create(:name => "Eleanor Rigby", :album => @album)
		@songs << Song.create(:name => "Taxman", :album => @album)
		@songs.each { |song| song.save}
	end
	after {clear_db }

	
	it "should return songs list" do
		songs_names = @songs.map {|song| song.name}
		get '/songs'
		expect(last_response.status).to eq(200)
		body = JSON.parse(last_response.body)
		expect(body.size).to eq(2)
		body.each do |song|
			expect(songs_names.include? song['name']).to be true
		end
	end
	
	it "should return right song" do
		song_id = @songs[0].id
		song_name = @songs[0].name
		get "/songs/#{song_id}"
		expect(last_response.status).to eq(200)
		body = JSON.parse(last_response.body)
		expect(body['name']).to eq(song_name)
	end
	
	it "should return 404 on wrong id" do
		song_id = 9
		get "/songs/#{song_id}"
		expect(last_response.status).to eq(404)
	end
end
