//= require "_lib/jquery.custom.min"

$(document).ready( function(){

	var keycodes = {};
	keycodes.g = '71';
	
	$('body').keyup( function(e){
		
		var kcode = ( e.keyCode ? e.keyCode : e.which );
		if( kcode == keycodes.g ) {
			$('#grid').toggleClass("visible");
		}

	});


});