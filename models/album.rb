class Album
	include DataMapper::Resource
	
	property :id,	Serial
	property :name,	String, :required => true
	
	has n, :songs
	has n, :users, :through => :user_albums
end  
