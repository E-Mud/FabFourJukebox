var QUERYSERVER = "fabfourjukebox.herokuapp.com"

var PLAYURL = "/me/play"
var LISTENEDURL = "/me/listened"
var ALBUMSURL = "/albums"

function queryAlbums(succesFunction){
    var asyncCall = !(typeof(succesFunction) === 'undefined')

    var albums = []
    var url = ALBUMSURL
    $.ajax({
        type: "GET",
        async: asyncCall,
        url: url,
        dataType: "json",
        success: function(data){
            albums = data

            if(asyncCall){
                succesFunction(albums)
            }
        }
    });

    if(!asyncCall){
        return albums;
    }
}

function playNewSong(succesFunction){
	var asyncCall = !(typeof(succesFunction) === 'undefined')

	var song = {}
	var url = PLAYURL
    $.ajax({
        type: "GET",
        async: asyncCall,
        url: url,
        dataType: "json",
        headers: { "Authorization": getAuthHeader()  },
        success: function(data){
            song = data
            if(asyncCall){
                succesFunction(song)
            }
        }
    });

    if(!asyncCall){
        return song;
    }
	
}

function queryAlbumSongs(albumHref, succesFunction){
    var asyncCall = !(typeof(succesFunction) === 'undefined')

    var songs = []
    $.ajax({
        type: "GET",
        async: asyncCall,
        url: albumHref,
        dataType: "json",
        headers: { "Authorization": getAuthHeader()  },
        success: function(data){
            songs = data.songs
            
            if(asyncCall){
                succesFunction(songs)
            }
        }
    });

    if(!asyncCall){
        return songs;
    }    
}

function queryListenedSongs(succesFunction){
	var asyncCall = !(typeof(succesFunction) === 'undefined')

	var songs = []
	var url = LISTENEDURL
    $.ajax({
        type: "GET",
        async: asyncCall,
        url: url,
        dataType: "json",
        headers: { "Authorization": getAuthHeader()  },
        success: function(data){
            songs = data

            if(asyncCall){
                succesFunction(songs)
            }
        }
    });

    if(!asyncCall){
        return songs;
    }
}