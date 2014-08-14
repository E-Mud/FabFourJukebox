require 'delegate'

class SongPresenter < DelegateClass(Song)
	def initialize(song, full = false)
		song.album = AlbumPresenter.new(song.album) if full
		@song = song
		super(@song)
	end
	
	def id
		Fabfourjukebox::App.url_for(:songs, :index, :id => @song.id)
	end
end 
