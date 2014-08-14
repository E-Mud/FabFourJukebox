require 'delegate'

class CompletedPresenter < AlbumPresenter
	def initialize(completed)
		@completed = completed
		super(@completed.album)
	end
	
	def completed_on
		@completed.completed_on
	end
end  
 
