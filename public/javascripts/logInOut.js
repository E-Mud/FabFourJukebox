var LOGINURL = "/auth"

function logIn(email, passwd, succesFunction, failureFunction){
	// createCookie('sesid', btoa(email+":"+passwd))
	// succesFunction()
    var asyncCall = !(typeof(succesFunction) === 'undefined')

    var url = LOGINURL
    $.ajax({
        type: "GET",
        async: asyncCall,
        url: url,
        dataType: "text",
        headers: { "Authorization": "Basic " + btoa(email+":"+passwd)  },
        error: failureFunction,
        success: function(data){

            createCookie('sesid', btoa(email+":"+passwd))
            if(asyncCall){
                succesFunction()
            }
        }
    });
}

function logOut(){
	deleteCookie('sesid')
	window.location.replace("./index.html")
}

function getAuthHeader(){
	return "Basic " + getCookie('sesid')
} 
