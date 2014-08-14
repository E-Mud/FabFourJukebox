require 'delegate'

class ListenedPresenter < SongPresenter
	def initialize(listened)
		@listened = listened
		super(@listened.song)
	end
	
	def listened_on
		@listened.listened_on
	end
end  
