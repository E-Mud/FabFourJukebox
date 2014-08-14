class Song
	include DataMapper::Resource
	
	property :id,	Serial
	property :name,	String, :required => true
	
	belongs_to :album
	has n, :users, :through => :user_songs
end 
