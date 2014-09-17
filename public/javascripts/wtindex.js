function showTodaysSong(){
	var playSong = $("#play-song").empty()

	playNewSong(function(song){
		playSong.append("<h1>Hoy deberias escuchar</h1>")
		playSong.append("<h2>" + song.name + " (" + song.album.name + ")</h2>")
	})
	populateListenedList()
}

function populateActiveAlbumSongsList(){
	var activeAlbumHref = $(".album-list-item.active").attr("id");
	var songsList = $("#album-songs").empty();

	queryAlbumSongs(activeAlbumHref, function(data){
		$.each(data, function(index, song) {
			songsList.append("<li class=\"list-group-item\">"+
				"<p class=\"inline\">"+song.name+"</p></li>");
		});
		songsList.offset({top : $('.album-list-item.active').offset().top})
	});
}

function populateAlbumsList(){
	var albumsList = $("#albums-list").empty();

	queryAlbums(function(data){
		$.each(data, function(index, album) {
				albumsList.append("<a id=\""+album.href+"\" class=\"list-group-item album-list-item\">"+album.name+"</a>");
		});

		if(albumsList.children().length > 0){
			albumsList.children(":first").addClass('active')
			albumsList.on('click', '.album-list-item', function(){
				$('.album-list-item.active').removeClass('active');
				$(this).addClass('active');

				populateActiveAlbumSongsList();
			})
			populateActiveAlbumSongsList();
		}else{
			albumsList.append("<p>No hay albums</p>");
		}
	});
}

function populateListenedList(){
	var listenedList = $("#listened-list").empty();

	queryListenedSongs(function(songs){
		$.each(songs, function(index, song) {
			listenedList.append("<li class=\"list-group-item\"><p>"+song.name+"</p>"+
				"<p>Escuchado: "+song.listened_on+"</p></li>");
		});
	})
}


function wtindexmain(){

	populateAlbumsList();
	populateListenedList();

	// $('#activities-list').on('click', '.activity-list-item', function(){
	// 	alert("clicked")
	// 	$('.activity-list-item.active').removeClass('active');
	// 	$(this).addClass('active');

	// 	populateActiveActivityResultsList();
	// })
	
	// $('.resultType-list-item').click(function(){
	// 	$($(".resultType-list-item.active").attr("href")).hide();
	// 	$(".resultType-list-item.active").removeClass("active");
		
	// 	$(this).addClass("active");
	// 	$($(this).attr("href")).show();
	// 	populateActiveResultList();
	// });

	$('#play-tab').click(function (e) {
		showTodaysSong()
	})

	$('#logout').click(function(){
		logOut();
	});
}

$(document).ready(wtindexmain);