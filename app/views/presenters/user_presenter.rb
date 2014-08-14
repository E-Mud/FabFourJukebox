require 'delegate'

class UserPresenter < DelegateClass(User)
	def initialize(user, full = false)
		if full
			user.songs = user.songs.intermediaries.map {|song| ListenedPresenter.new(song) }
			user.albums = user.albums.intermediaries.map{|album| CompletedPresenter.new(album) }
		end
		@user = user
		super(@user)
	end
	
	def id
		Fabfourjukebox::App.url_for(:users, :index, :id => @user.id)
	end
end
