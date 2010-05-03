(function($){

	$.project = function(){
		
		var autosaver, old_form_contents;
		var save = function(e){
			if (e&&e.preventDefault) { e.preventDefault(); }
			
		}
		
		$('#save').click(save);
		

		$(document).keyup(function(){
			clearInterval($.project.autosaver);
			var content = $("#content").serialize();
			if (old_form_contents != content) // if there is a change
			{
				old_form_contents = content;
  				$.project.autosaver = setTimeout($.project.save,1000 );    // wait 2 seconds after typing to save
			}
		});

		
		return {
			save : save,
			autosaver: autosaver
		}
	}();
}(jQuery));
function trace(msg) { if (console&&console.log){console.log(msg);}}