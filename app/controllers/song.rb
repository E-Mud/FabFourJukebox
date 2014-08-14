Fabfourjukebox::App.controllers :songs do
  get :index do
	  @songs = Song.all.map{ |song| SongPresenter.new(song)}
	  status 200
	  render 'song/list_song'
  end
  
  get :index, :with => :id do
	  song = Song.get(params[:id].to_i)
	  if song
		  @song = SongPresenter.new(song, true)
		  status 200
		  render 'song/song_full'
	  else
		  status 404
	  end
  end

end
