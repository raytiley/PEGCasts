	jQuery.ajaxSetup({
		'beforeSend': function(xhr) { xhr.setRequestHeader("Accept", "text/javascript")}
	});

	jQuery.fn.replyWithAjax = function() {
	  this.click(function() {
	    $.get($(this).attr("href"), {
			reply_title: $(this).parents(".comment").find(".commentSubject").text(),
			div: $(this).parents(".comment").attr("id")}, null, "script");
		return false;
	  })
	  return this;
	};

	$('document').ready(function(){
		$(".replyLink").replyWithAjax();
	});