object @album

extends 'album/album'
child :songs => :songs do
	extends 'song/song'
end 
