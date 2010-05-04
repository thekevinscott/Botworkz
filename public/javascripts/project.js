(function($){

	$.project = function(){
		
		var autosaver;
		var old_form_contents = $('#content').val();
		var save = function(e){
			if (e&&e.preventDefault) { e.preventDefault(); }
			
			$.post('/notes/new',{project_id:$('#project').attr('rel'),content:$('#content').val()},function(data){
				if (data.note) {
					$('form #update-save').html("Saved successfully at "+Date(data.note.created_at)).show().delay(1500).fadeOut();
					$('form #content-rev a').html("Rev: "+data.note.rev);
				}
			},'json');
		}
		
		$('#save').click(save);
		

		$(document).keyup(function(){
			clearInterval($.project.autosaver);
			$.project.autosaver = setTimeout(function(){
				var content = $("#content").val();
				if (old_form_contents != content) // if there is a change
				{
					old_form_contents = content;
					$.project.save();
				}
				
			},1000 );    // wait 2 seconds after typing to save
		});

		
		return {
			save : save,
			autosaver: autosaver,
			old_form_contents: old_form_contents
		}
	}();
}(jQuery));
function trace(msg) { if (console&&console.log){console.log(msg);}}