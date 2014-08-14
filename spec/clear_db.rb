def clear_db
	Completed.all.destroy
	Listened.all.destroy
	User.all.destroy
	Song.all.destroy
	Album.all.destroy
end
