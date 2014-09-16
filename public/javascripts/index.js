function onLoggedIn(){
	var sesid = getCookie('sesid')
	//alert(sesid)
	if(sesid != null && sesid !=''){
		window.location.replace("./ffjukebox.html")
	}
}

function indexmain(){
	$('#login').click(function(){
		var username = $('#email').val();
		var password = $('#passwd').val();
		logIn(username, password, onLoggedIn, function(){
			alert("WRONG");
		})
	})
}

$(document).ready(indexmain)
 
