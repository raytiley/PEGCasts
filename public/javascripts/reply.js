	jQuery.ajaxSetup({
		'beforeSend': function(xhr) { xhr.setRequestHeader("Accept", "text/javascript")}
	});

	jQuery.fn.replyWithAjax = function() {
	  this.click(function() {
	    $.get($(this).attr("href"), {
			reply_title: $(this).parents(".comment").find(".commentSubject").text(),
			div: $(this).parents(".comment").attr("id")}, function() {
				Recaptcha.create("6LeYBwkAAAAAAI3f8N_yNxz-b4U6mw3xLgNWDaHH",
				    "ajax_recaptcha",
				    {
				      theme: "red",
				      callback: Recaptcha.focus_response_field
				    }
				  );
			}, "script");
		return false;
	  })
	  return this;
	};

	$('document').ready(function(){
		$(".replyLink").replyWithAjax();
			Recaptcha.create("6LeYBwkAAAAAAI3f8N_yNxz-b4U6mw3xLgNWDaHH",
			    "comment_recaptcha",
			    {
			      theme: "red",
			      callback: Recaptcha.focus_response_field
			    }
			  );
	});