function logIn(email, passwd, succesFunction, failureFunction){
	createCookie('sesid', btoa("nex@mentira.com:123456"))
	succesFunction()
}

function logOut(){
	deleteCookie('sesid')
	window.location.replace("./index.html")
}

function getAuthHeader(){
	return "Basic " + getCookie('sesid')
} 
