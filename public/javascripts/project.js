(function($){
	
	$.fn.loading = function() {
		$(this).html('<img src="/images/loadingAnimation.gif" />')
	}

	$.project = function(){
		
		$(document).ready(function(){
			$.project.add_clicks();			
			$('#windows-tabs a#add-panel').click(add_new_tab);
			$('#windows a:first').click();
			$.project.update_panels();	// get our initial list of panels
		});
		
		var add_new_tab = function(e) {
			e.preventDefault();
			$(this).parent().before('<input type="text" />');
			$(this).parent().parent().find('input').focus().keyup(function(e){
				var ths = this;
				var val = $(this).val();
				if (e.keyCode==13) {
					$.post(window.location.pathname+'/addPanel',{panel:val},function(data){
						if (data) {
							$.project.add_new_panel(ths,data.panel);
						}
					},'json');

				}
			});
		}
		var add_new_panel = function(ths,panel) {
			var title = panel.title;
			var css = panel.css_name;
			
			var newTab = $('<li id="tab-'+css+'" class="selected"><a href="'+css+'">'+title+'</a></li>');
			

			
			var newPanel = $('\
				<div id="'+css+'" class="window-pane selected panel">\
					<form action="" method="post">\
					  <div class="content-rev"><a href="javascript:;">Rev: 1</a></div>\
					  <div class="text-container"><textarea cols="40" rows="20" name="content" class="content"></textarea></div>\
					  <input type="submit" value="Save" name="save" class="save submit">\
					  <div class="update-save-container"><span class="update-save"></span></div>\
					</form>\
					<div class="clear"></div>\
					</div>');

			$(ths).replaceWith(newTab);
			$('#windows').append(newPanel);
			
			add_clicks();
			$(newTab).find('a').click();
			$.project.update_panels();
			
		}
		
		var add_clicks = function() {
			$('#windows-tabs a:not(#add-panel)').unbind('click').click(function(e){
				e.preventDefault();
				target = $(this).attr('href');
				$('.window-pane:visible, #windows-tabs li.selected').removeClass('selected');
				$('#'+target+', #windows-tabs li#tab-'+target).addClass('selected');
			});
		}
	
		
		
		
		
		
		
		
		
		
		
		var panel_object = {};

		var update_panels = function() {
			// this will look at our board and see what panels we have
			
			$('.panel').each(function(){
				var id = $(this).attr('id');
				
				if (! panel_object[id]) {
					panel_object[id] = {old_form_contents: $('#'+id+' .content').val()};
					$('#'+id+' .save').click(save);
				}
			});
		}
		
		var save = function(e,live_panel){
			if (e&&e.preventDefault) { e.preventDefault(); }
			var panel = live_panel || $(this).parent().parent();
			var id = panel.attr('id');
			var pobj = panel_object[id];
			
			if (pobj.autosaver) { clearInterval(pobj.autosaver); }
			
			panel.find('.update-save').show().loading();
			
			var post = {	
							project_id: $('#project').attr('rel'), 
							content: panel.find('.content').val(), 
							panel: id
						};
			
			$.post('/notes/new', post, function(data){
				if (data.note) {
					panel.find('.update-save').html("Saved successfully at "+Date(data.note.created_at)).css({background: '#ffff99'}).animate({backgroundColor:"#DDDDDD"},1000).delay(2000).fadeOut(1500);
					panel.find('.content-rev a').html("Rev: "+data.note.rev);
				}
			},'json');
		}
		
		

		$(document).keyup(function(){
			// what's our live panel?
			var panel = $('.window-pane:visible');
			var id = panel.attr('id');
			var pobj = panel_object[id];
			if (pobj && pobj.autosaver) { clearInterval(pobj.autosaver); }

			
			pobj.autosaver = setTimeout(function(){
				
				trace(panel);
				trace(panel_object);
								
				var content = panel.find('.content').val();
				trace(content);
				if (pobj.old_form_contents != content) // if there is a change
				{
					pobj.old_form_contents = content;
					$.project.save(null,panel);
				}
				
			},2000 );    // wait 2 seconds after typing to save
			
			
		});
		
		
		
		
		return {
			save : save,
			add_new_panel : add_new_panel,
			add_clicks : add_clicks,
			update_panels: update_panels
		}
	}();
}(jQuery));
function trace(msg) { if (console&&console.log){console.log(msg);}}