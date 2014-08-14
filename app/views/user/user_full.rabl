object @user

extends 'user/user'
child :songs => :listened_songs do
	extends 'song/song'
	attributes :listened_on
end
child :albums => :completed_albums do
	extends 'album/album'
	attributes :completed_on
end
