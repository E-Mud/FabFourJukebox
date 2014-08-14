require 'delegate'

class AlbumPresenter < DelegateClass(Album)
	def initialize(album, full = false)
		album.songs.map! {|song| SongPresenter.new(song)} if full
		@album = album
		super(@album)
	end
	
	def id
		Fabfourjukebox::App.url_for(:albums, :index, :id => @album.id)
	end
end 
