(function($){
	
	$.fn.loading = function() {
		$(this).html('<img src="/images/loadingAnimation.gif" />')
	}

	$.project = function(){
		
		var autosaver;
		var old_form_contents = $('#content').val();
		var save = function(e){
			if (e&&e.preventDefault) { e.preventDefault(); }
			
			$('form #update-save').show().loading();
			
			$.post('/notes/new',{project_id:$('#project').attr('rel'),content:$('#content').val()},function(data){
				if (data.note) {
					$('form #update-save').html("Saved successfully at "+Date(data.note.created_at)).css({background: '#ffff99'}).animate({backgroundColor:"#DDDDDD"},1000).delay(2000).fadeOut(1500);
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
				
			},2000 );    // wait 2 seconds after typing to save
		});
		
		$(document).ready(function(){		
			$('#windows-tabs a').click(function(e){
				target = $(this).attr('href');
				$('.window-pane:visible, #windows-tabs li.selected').removeClass('selected');
				$('#'+target+', #windows-tabs li#tab-'+target).addClass('selected');
				e.preventDefault();	
			});
		});
		
		return {
			save : save,
			autosaver: autosaver,
			old_form_contents: old_form_contents
		}
	}();
}(jQuery));
function trace(msg) { if (console&&console.log){console.log(msg);}}