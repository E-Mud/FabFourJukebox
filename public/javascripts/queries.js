var QUERYSERVER = "fabfourjukebox.herokuapp.com"

var PLAYURL = QUERYSERVER + "/me/play"
var LISTENEDURL = QUERYSERVER + "/me/listened"
var ALBUMSURL = QUERYSERVER + "/albums"

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
            alert(typeof(data))
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
        headers: { "Authorization": getAuthHeader()  }
        success: function(data){
            alert(typeof(data))
            

            if(asyncCall){
                succesFunction(song)
            }
        }
    });

    if(!asyncCall){
        return song;
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
        headers: { "Authorization": getAuthHeader()  }
        success: function(data){
            alert(typeof(data))

            if(asyncCall){
                succesFunction(songs)
            }
        }
    });

    if(!asyncCall){
        return songs;
    }
}