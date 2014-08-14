class AlbumUser
	include DataMapper::Resource
	
	property :completed_on, Date, :default => lambda { |r,p| Date.today }
	
	belongs_to :user, :key => true
	belongs_to :album, :key => true
end

Completed = AlbumUser
