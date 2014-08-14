class SongUser
	include DataMapper::Resource
	
	property :listened_on, Date, :default => lambda { |r,p| Date.today }
	
	belongs_to :user, :key => true
	belongs_to :song, :key => true
end

Listened = SongUser
