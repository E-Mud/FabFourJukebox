require 'spec_helper'
require 'clear_db'
require 'json'

describe 'UserTemplate' do
	before { clear_db }
	after {clear_db }
	
	it "should have the right email" do
		user = UserPresenter.new(User.create(:email => "nex@gmail.com", :password => "123456"))
		result = JSON.parse(Rabl::Renderer.json(user, 'user/user'))
		expect(result['email']).to eq(user.email)
	end
	
	it "should not show the password" do
		user = UserPresenter.new(User.create(:email => "nex@gmail.com", :password => "123456"))
		result = JSON.parse(Rabl::Renderer.json(user, 'user/user'))
		expect(result['password']).to be_nil
	end
	
	it "should have the right created_on" do
		user = UserPresenter.new(User.create(:email => "nex@gmail.com", :password => "123456"))
		result = JSON.parse(Rabl::Renderer.json(user, 'user/user'))
		expect(result['created_on']).to eq(user.created_on.to_s)
	end
	
	it "should have the right last_song_at" do
		user = UserPresenter.new(User.create(:email => "nex@gmail.com", :password => "123456"))
		user.last_song_at = Date.today
		result = JSON.parse(Rabl::Renderer.json(user, 'user/user'))
		expect(result['last_song_at']).to eq(user.last_song_at.to_s)
	end
	
	it "should have the right songs" do
		user = User.create(:email => "nexususer@gmail.com", :password => "123456")
		album = Album.create(:name =>"Revolver")
		songs = []
		songs << Song.create(:name => "Eleanor Rigby", :album => album)
		songs << Song.create(:name => "Taxman", :album => album)
		Listened.create(:user => user, :song => songs[0])
		Listened.create(:user => user, :song => songs[1])
		
		result = JSON.parse(Rabl::Renderer.json(UserPresenter.new(user, true), 'user/user_full'))
		result['listened_songs'].each.with_index do |song, i|
			expect(song['name']).to eq(songs[i].name)
			expect(song['listened_on']).to eq(Date.today.to_s)
		end
	end
	
	it "should have the right albums" do
		user = User.create(:email => "nexususer@gmail.com", :password => "123456")
		album = Album.create(:name => "Revolver")
		rel = Completed.create(:user => user, :album => album)
		
		result = JSON.parse(Rabl::Renderer.json(UserPresenter.new(user, true), 'user/user_full'))
		result['completed_albums'].each do |alb|
			expect(alb['name']).to eq(album.name)
			expect(alb['completed_on']).to eq(Date.today.to_s)
		end
	end
	
	it "list should have the right users" do
		User.create(:email => "nex@gmail.com", :password => "123456").save
		User.create(:email => "nexus@gmail.com", :password => "123456").save
		users = User.all.map {|user| UserPresenter.new(user) }
		users_email = users.map {|user| user.email}
		result = JSON.parse(Rabl::Renderer.json(users, 'user/list_user'))
		result.each do |user|
			expect(users_email.include? user['email']).to be true
		end
	end
end 
