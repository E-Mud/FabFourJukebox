Fabfourjukebox::App.controllers :me do
	include HttpAuthentication::Basic

	before do
		if request.request_method != 'POST'
			credentials = authenticate_with_http_basic
			halt(401) unless !credentials.nil? && (@requester = User.authenticate(credentials[0], credentials[1]))
		end
	end
	
	error 401 do
		request_http_basic_authentication
	end

	get :play do
		if @requester.last_song_at == Date.today
			@song = Listened.find(:user => @requester, :listened_on => Date.today).song
		else
			listened_songs_ids = Listened.all(:user => @requester).map {|ltd| ltd.song.id}
			@requester.update(:last_song_at => Date.today)
			if listened_songs_ids.size == Song.count
				@song = Song.first(:offset => rand(Song.count))
			else
				loop do
					@song = Song.first(:offset => rand(Song.count))
					break unless listened_songs_ids.include? @song.id
				end
				Listened.create(:user => @requester, :song => @song)
			end
			
		end
		
		@song = SongPresenter.new(@song, true)
		status 200
		render 'song/song_full'
	end
end
