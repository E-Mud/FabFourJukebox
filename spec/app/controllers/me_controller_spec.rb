require 'spec_helper'
require 'base64'

describe "MeController" do
	before do
		clear_db
		@user = User.create(:email => "nex@gmail.com", :password => "123456")
		@user.save
		@songs = []
		@album = Album.create(:name => "Revolver")
		@songs << Song.create(:name => "Eleanor Rigby", :album => @album)
		@songs << Song.create(:name => "Taxman", :album => @album)
	end

	after do
		clear_db
	end

	def basic_auth(email, psswd)
		"Basic " + Base64.encode64(email + ":" + psswd)
	end

	def get_a_song
		get '/me/play', {}, 'HTTP_AUTHORIZATION' => basic_auth(@user.email, @user.password)

		expect(last_response.status).to eq(200)

		JSON.parse(last_response.body)
	end

	def get_listened_songs
		get '/me/listened', {}, 'HTTP_AUTHORIZATION' => basic_auth(@user.email, @user.password)

		expect(last_response.status).to eq(200)

		JSON.parse(last_response.body)
	end

	it "should forbid a wrong user" do
		get '/me/play', {}, 'HTTP_AUTHORIZATION' => basic_auth("wrong_email@gmail.com", "123456")

		expect(last_response.status).to eq(401)
	end

	it "should play a random new song" do
		body = get_a_song

		expect(body['name'].nil?).to be false
		expect(body['href'].nil?).to be false
		expect(body['album'].nil?).to be false
	end

	it "should not play an earlier listened song" do
		Listened.create(:user => @user, :song => @songs[0], :listened_on => Date.today - 1)
		body = get_a_song

		expect(body['name']).not_to eq(@songs[0].name)
	end

	it "should save today" do
		get_a_song

		@user = User.get(@user.id)
		expect(@user.last_song_at).to eq(Date.today)
	end

	it "today should play today song" do
		Listened.create(:user => @user, :song => @songs[0])
		@user.update(:last_song_at => Date.today)
		body = get_a_song

		expect(body['name']).to eq(@songs[0].name)
	end

	it "should save it as listened" do
		listened_before = Listened.all(:user => @user).size
		get_a_song
		listened_after = Listened.all(:user => @user).size

		expect(listened_after).to eq(listened_before+1)
	end

	it "should return listened songs" do
		Listened.create(:user => @user, :song => @songs[1], :listened_on => Date.today-3)
		Listened.create(:user => @user, :song => @songs[0], :listened_on => Date.today-2)

		songs = get_listened_songs

		p songs
		expect(songs.size).to eq(2)
	end
end 
