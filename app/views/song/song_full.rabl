object @song

extends 'song/song'
child :album => :album do
	extends 'album/album'
end 
