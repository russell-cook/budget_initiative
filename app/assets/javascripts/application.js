// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require jquery.turbolinks
//= require_tree .

$(document).foundation();

//= require turbolinks

// confirm unsaved changes on form exit

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
	        return "You have unsaved changes on this page. Do you want to leave this page and discard your changes or stay on this page?";
	    }
	}

	window.onbeforeunload = unloadPage;

});
