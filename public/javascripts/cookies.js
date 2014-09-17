function getCookie(name) {
	var value = "; " + document.cookie;
	//alert(value);
	var parts = value.split("; " + name + "=");
	if (parts.length == 2){
		return parts.pop().split(";").shift();
	}else{
		return null;
	}
} 

function deleteCookie( name ) {
	document.cookie = name + '=; expires=Thu, 01 Jan 1970 00:00:01 GMT;';
}

function createCookie(name, value, days){
	document.cookie = name + '='+value+'; expires=Thu, 01 Jan 2070 00:00:01 GMT;';
}
