$(document).ready(function () {

	var unsaved = false;

	$(":input").click(function(){ //trigers change in all input fields including text type
	    unsaved = true;
	});

	$(':submit').click(function() {
	    unsaved = false;
	});

	function unloadPage(){ 
	    if(unsaved){
	        return "You have unsaved changes on this page.";
	    }
	}

	window.onbeforeunload = unloadPage;

});
