(function($) {
$.fn.akdelay = function(time, callback){
jQuery.fx.step.delay = function(){};
return this.animate({delay:1}, time, callback);
}
})(jQuery);
$(document).ready(function() {
	$('*').removeClass('no-js');
	//Enables linking to specific tabs on Top 10 pg
	enableTab();
	//Removes/Adds Placeholder text onfocus/onblur on forms
	formToggle();
	//Mobile navigation set up
	mobileNavToggle();
	
	$('.filter-toggle a').click(function(){
		$('.filter-toggle a').removeClass('active');
		$(this).addClass('active');
	})
	
	//top 10 mobile navigation on page load
	var top10toggle = true;
	if($(window).width() < 767){
		$('.nav-tabs li:not(.active)').toggle('fast');
		$('.nav-tabs li.active').css('display','list-item').removeClass('active');
		$('.tab-content .tab-pane.active:first').removeClass('active');
		
	}	
	
		$('.nav-tabs li a').click(function(){
			if($(window).width() < 767){
				$('.nav-tabs').prepend($(this).parent());
				if($(this).parent().hasClass('active')){
					if(top10toggle == false){
						top10toggle = true;
						$('.nav-tabs li.active').addClass('t10up');
					}
					else{
						top10toggle = false;
						$('.nav-tabs li').removeClass('t10up');
					}
					$('.nav-tabs li:not(.active)').toggle('fast');
					$('.nav-tabs li.active').css('display','list-item');
				}
				else{
					$('.nav-tabs li').css('display','');
					top10toggle = false;
					$('.nav-tabs li').removeClass('t10up');
				}
			}
		});
	
	
	var paginationMargin = $('.templateB .span10 .pagination_1 a').size()*$('.templateB .span10 .pagination_1 a').eq(0).width()+70;
	$('.templateB .pagination_1 a.prev').css('marginLeft', (($('.templateB .span10 .pagination_1').width()/2) - (paginationMargin/2)));
	//LEAD GEN MODAL WINDOW SET UP (ALSO THANK YOU MODAL)
	$('.dl-report-btn_1').click(function(event){
		event.preventDefault();
		$('html, body').animate({scrollTop:0}, 'slow');
		$('#modal-lead-gen').modal();
	});
	$('.contact-modal').click(function(event){
		event.preventDefault();
		$('html, body').animate({scrollTop:0}, 'slow');
		$('#modal').modal();
	});
	$('#modal-lead-gen input[type=submit].submit-lead-gen').click(function(event){
		event.preventDefault();
		$('html, body').animate({scrollTop:0}, 'slow');
		$('#modal-lead-gen').modal('hide');
		$('#modal').modal('hide');
		$('#modal-thanks').modal();
		//this code hides the initial lead gen (blue) button when the form is submitted
		$('.dl-report-btn_1').hide();
		//this code shows the download report (green) button
		$('.dl-report2-btn').show();
	});
	$('#modal-lead-gen input[type=submit].cancel-lead-gen').click(function(event){
		event.preventDefault();
		$('#modal-lead-gen').modal('hide');
		$('#modal').modal('hide');
		//$('#modal-thanks').modal();
	});
	$('.close-modal').click(function(event){
		event.preventDefault();
		$('#modal-lead-gen').modal('hide');
		$('#modal').modal('hide');
		$('#modal-thanks').modal('hide');
	});
	var windowHeight = $(window).height();
	var modalPlacement = $(window).width();
	$('.modal').each(function(){
	    /*$(this).children('.modal-body').height(windowHeight*.9);*/
		$(this).css('left', (.5*modalPlacement)-($(this).width()*.5));
		
	});
	/*Top10: activates tabs and their respective content areas.*/
	$('.nav-tabs a').click(function(event){
		event.preventDefault();
		$(this).tab('show');
	});
	/*Top10: activates change of content area on select value change*/
	$('.tab-pane_1 select').change(function(){
		$('.tab-pane_1.active .tab-pane_1.active').fadeOut(300).removeClass('active');
		subTab = $('.tab-pane_1.active select option:selected').val();
		//console.log(subTab);
		$('#'+subTab).fadeIn(500).addClass('active');
	});
	if($(window).width() > 767){
		var tabCounter = $('.top10 .nav-tabs li').length;
		$('.top10 .nav-tabs li').width(($('.top10 .nav-tabs').width()/tabCounter)-.1);
	}
	
	$(window).resize(function(){
		if($(window).width() > 767){
			$('.nav-tabs li').css('display','');
		}		
		moveTopTen();
		windowHeight = $(window).height();
		modalPlacement = $(window).width();
		$('.modal').each(function(){
		    /*$(this).children('.modal-body').height(windowHeight*.9);*/
			$(this).css('left', (.5*modalPlacement)-($(this).width()*.5));
		});
		
		
		var paginationMargin = $('.templateB .span10 .pagination_1 a').size()*$('.templateB .span10 .pagination_1 a').eq(0).width()+70;
		$('.templateB .pagination_1 a.prev').css('marginLeft', (($('.templateB .span10 .pagination_1').width()/2) - (paginationMargin/2)));
	
		if($(window).width() > 767){
			var tabCounter = $('.top10 .nav-tabs li').length;
			$('.top10 .nav-tabs li').width(($('.top10 .nav-tabs').width()/tabCounter)-.1);
		}
		else{
			$('.top10 .nav-tabs li').css('width','100%');
		}
		//console.log($(window).width());
		var leftTo;
		var rightTo;
		if($(window).width() > 1024){
			leftTo = '95px';
			rightTo = '95px';
		}
		else if($(window).width() >= 440 && $(window).width() <= 767){
			leftTo = '60px';
			rightTo = '20px';

		}
		else if($(window).width() < 440){
			leftTo = '40px';
			rightTo = '40px';
		}
		else{
			leftTo = '70px';
			rightTo = '70px';
		}
		$('.rslides1_on').find('.rightside .text-wrap').css('right',leftTo);
		$('.rslides1_on').find('.leftside .text-wrap').css('left',leftTo);
	});
	//top10 equal width li elements
	$('.tooltip-link').click(function(event){
		event.preventDefault();
	});
	$('.tooltip-link').tooltip();
	//top 10 mobile page
	$('.top10 .banner-wrap a').click(function(){
		if($(window).width() < 767){
			location.reload();
		}
	});
	
	
});

function enableTab(){
	var url = document.location.toString();
	if (url.match('#')) {
	    $('.nav-tabs a[href=#'+url.split('#')[1]+']').tab('show') ;
	} 
}
function formToggle(){
	var Input = $('input.search_newswire');
	var default_value = Input.val();	
	    Input.focus(function() {
	        if(Input.val() == default_value) Input.val("");
	    }).blur(function(){
	        if(Input.val().length == 0) Input.val(default_value);
	    });
	
	var Input2 = $('input.search-query');
	var default_value2 = Input2.val();
		Input2.focus(function() {
	        if(Input2.val() == default_value2) Input2.val("");
	    }).blur(function(){
	        if(Input2.val().length == 0) Input2.val(default_value2);
	    });
}
function mobileNavToggle(){
	//mobile navigation set up
	var toggleClicked = false;
	$(window).resize(function() {
		if($(window).width() > 767){
			$('.main-nav').css('display', 'block');
			$('.main-nav-toggle').removeClass('uparrow');
		}
		else{
			if(toggleClicked == true){
				$('.main-nav-toggle').addClass('uparrow');
				$('.main-nav').css('display','block');
			}
			else{
				$('.main-nav-toggle').removeClass('uparrow');
				$('.main-nav').css('display','none')	
			}
		}
		
	});
	$('.main-nav-toggle').click(function(event){
		event.preventDefault();
		$('.main-nav').toggle('fast');
		if($('.main-nav-toggle').hasClass('uparrow')){
			$('.main-nav-toggle').removeClass('uparrow');
			toggleClicked = false;
		}
		else{
			toggleClicked = true;
			$('.main-nav-toggle').addClass('uparrow');	
		}
	});
}
function moveTopTen(){
	if($(window).width() >= 767){
	  if(!$('.featured-home .span8.top10').parent().hasClass('right') && !$('.span8.top10').hasClass('top')){
		var box1Height = $('.featured-home .span4.first').height();
		var box2Height = $('.featured-home .span4.reports').height();
		var box3Height = $('.featured-home .span4.homeSolutions').height();
		var t10mar = -106;
		if(box3Height > 281){
			var change = box3Height - 281;
			t10mar = t10mar - change;
			$('.featured-home .span8.top10').css('marginTop', t10mar);
		}
		if(box1Height >= box2Height){
			if(box1Height > 158){
				var dif = box1Height - 158;
				$('.featured-home .span4').css('margin', '');
				$('.featured-home .span8.top10').css('marginTop', t10mar+dif );
				//$('.featured-home .span4.reports').height(box1Height);
			}
		}
		else{
			var dif = box2Height - 158;
			$('.featured-home .span4').css('margin', '');
			$('.featured-home .span8.top10').css('marginTop', t10mar+dif );
			$('.featured-home .span4.first').height(box2Height);
		}
	  }
	  else{
		$('.featured-home .span8.top10').css('margin', '');
		$('.featured-home .span4').css('margin', '');
	  }
	}
	else if($(window).width() < 767){
		$('.featured-home .span8.top10').css('margin', '0px 0px 0px 0px');
		$('.featured-home .span4').css('margin', '0px 0px 0px 0px');
	}
	
}
function slideOut(direction){
	var animateTo = ($(window).width()/1.7)*(-1);
	var leftTo;
	var rightTo;
	if($(window).width() > 1024){
		leftTo = '95px';
		rightTo = '95px';
	}
	else if($(window).width() >= 440 && $(window).width() <= 767){
		leftTo = '60px';
		rightTo = '20px';
		
	}
	else if($(window).width() < 440){
		leftTo = '40px';
		rightTo = '40px';
	}
	else{
		leftTo = '70px';
		rightTo = '70px';
	}
	$('.rslides1_on').find('img.insightGraphic').akdelay(0, function(){
			$(this).animate({ opacity: '0' }, 500);
	});
	$('.rslides1_on .leftside .text-wrap').animate({
		left: animateTo},1400,'easeInExpo',function(){
		if($('.rslides1_on').hasClass('last') && direction == 'next'){
			animateFirstSlide(leftTo, rightTo);
		}
		else if($('.rslides1_on').hasClass('first') && direction == 'prev'){
			animateLastSlide(leftTo, rightTo)
		}
		else if(direction == 'next'){
			animateNextSlide(leftTo, rightTo);
		}
		else{
			animatePrevSlide(leftTo, rightTo);
		}
		
	});
	$('.rslides1_on .leftside .text-wrap h1').animate({
		left: animateTo}, 1050,'easeInExpo');
	$('.rslides1_on .leftside .text-wrap p').animate({
		left: animateTo}, 1200,'easeInExpo');
	$('.rslides1_on .leftside .text-wrap h1').animate({
		left: animateTo}, 1350,'easeInExpo');
		
	$('.rslides1_on .rightside .text-wrap').animate({
		right: animateTo},1400,'easeInExpo',function(){
			if($('.rslides1_on').hasClass('last') && direction == 'next'){
				animateFirstSlide(leftTo, rightTo);
			}
			else if($('.rslides1_on').hasClass('first') && direction == 'prev'){
				animateLastSlide(leftTo, rightTo)
			}
			else if(direction == 'next'){
				animateNextSlide(leftTo, rightTo);
			}
			else{
				animatePrevSlide(leftTo, rightTo);
			}
	});
	$('.rslides1_on .rightside .text-wrap h1').animate({
		right: animateTo}, 1050,'easeInExpo');
	$('.rslides1_on .rightside .text-wrap p').animate({
		right: animateTo, left: -animateTo}, 1200,'easeInExpo');
	$('.rslides1_on .rightside .text-wrap a').animate({
		right: animateTo, left: -animateTo}, 1350,'easeInExpo');
}

function animateNextSlide(leftTo, rightTo){
	$('.rslides1_on').next().find('a.cta-btn').css({left: '',right: ''});
	$('.rslides1_on').next().find('p').css({left: '',right: ''});
	$('.rslides1_on').next().find('h1').css({left: '',right: ''});
	$('.rslides1_on').next().find('.leftside .text-wrap').animate({
		left: leftTo}, 1000,'easeOutExpo');
	$('.rslides1_on').next().find('p').akdelay(300, function(){
			$(this).animate({ left: '0' }, 1000, 'easeOutBack');
	});
	$('.rslides1_on').next().find('a.cta-btn').akdelay(300, function(){
			$(this).animate({ left: '0' }, 1000, 'easeOutBack');
	});
	$('.rslides1_on').next().find('.rightside .text-wrap').animate({
		right: rightTo},1000,'easeOutExpo');
	$('.rslides1_on').next().find('img.insightGraphic').akdelay(400, function(){
			$(this).animate({ opacity: '1' }, 1200);
	});
	
}
function animateFirstSlide(leftTo, rightTo){
	$('.rslides .first').find('a.cta-btn').css({left: '',right: ''});
	$('.rslides .first').find('p').css({left: '',right: ''});
	$('.rslides .first').find('h1').css({left: '',right: ''});
	$('.rslides .first').find('.leftside .text-wrap').animate({
		left: leftTo}, 1000,'easeOutExpo');
	$('.rslides .first').find('p').akdelay(300, function(){
			$(this).animate({ left: '0' }, 1000, 'easeOutBack');
	});
	$('.rslides .first').find('a.cta-btn').akdelay(300, function(){
			$(this).animate({ left: '0' }, 1000, 'easeOutBack');
	});
	$('.rslides .first').find('.rightside .text-wrap').animate({
		right: rightTo},1000,'easeOutExpo');
	$('.rslides .first').find('img.insightGraphic').akdelay(400, function(){
			$(this).animate({ opacity: '1' }, 1200);
	});
}
function animatePrevSlide(leftTo, rightTo){
	$('.rslides1_on').prev().find('a.cta-btn').css({left: '',right: ''});
	$('.rslides1_on').prev().find('p').css({left: '',right: ''});
	$('.rslides1_on').prev().find('h1').css({left: '',right: ''});
	$('.rslides1_on').prev().find('.leftside .text-wrap').animate({
		left: leftTo}, 1000,'easeOutExpo');
	$('.rslides1_on').prev().find('p').akdelay(300, function(){
			$(this).animate({ left: '0' }, 1000, 'easeOutBack');
	});
	$('.rslides1_on').prev().find('a.cta-btn').akdelay(300, function(){
			$(this).animate({ left: '0' }, 1000, 'easeOutBack');
	});
	$('.rslides1_on').prev().find('.rightside .text-wrap').animate({
		right: rightTo},1000,'easeOutExpo');
	$('.rslides1_on').prev().find('img.insightGraphic').akdelay(400, function(){
			$(this).animate({ opacity: '1' }, 1200);
	});
}
function animateLastSlide(leftTo, rightTo){
 	$('.rslides .last').find('a.cta-btn').css({left: '',right: ''});
	$('.rslides .last').find('p').css({left: '',right: ''});
	$('.rslides .last').find('h1').css({left: '',right: ''});
	$('.rslides .last').find('.leftside .text-wrap').animate({
		left: leftTo}, 1000,'easeOutExpo');
	$('.rslides .last').find('p').akdelay(300, function(){
			$(this).animate({ left: '0' }, 1000, 'easeOutBack');
	});
	$('.rslides .last').find('a.cta-btn').akdelay(300, function(){
			$(this).animate({ left: '0' }, 1000, 'easeOutBack');
	});
	$('.rslides .last').find('.rightside .text-wrap').animate({
		right: rightTo},1000,'easeOutExpo');
		$('.rslides .last').find('img.insightGraphic').akdelay(400, function(){
				$(this).animate({ opacity: '1' }, 1200);
		});
}
function solutionsAnimation(){
	$('.solutions-frame').show();
	$('.solutions-frame1').akdelay(1400, function(){
		$('.solutions-frame1').fadeOut('slow');
	});
	$('.solutions-frame2').akdelay(2800, function(){
		$('.solutions-frame2').fadeOut('slow');
	});
	$('.solutions-frame3').akdelay(4200, function(){
		$('.solutions-frame3').fadeOut('slow');
	});
	$('.solutions-frame4').akdelay(5800, function(){
		$('.solutions-frame4').fadeOut('slow');
	});
}
function rotateSolutions(){
	$('.solutions-textRotation li:last').fadeOut('slow').prev().fadeIn('slow');
	var liFirst = $('.solutions-textRotation li:last').detach();
	$(liFirst).prependTo('.solutions-textRotation');
	
}
(function(doc) {

	var addEvent = 'addEventListener',
	    type = 'gesturestart',
	    qsa = 'querySelectorAll',
	    scales = [1, 1],
	    meta = qsa in doc ? doc[qsa]('meta[name=viewport]') : [];

	function fix() {
		meta.content = 'width=device-width,minimum-scale=' + scales[0] + ',maximum-scale=' + scales[1];
		doc.removeEventListener(type, fix, true);
	}

	if ((meta = meta[meta.length - 1]) && addEvent in doc) {
		fix();
		scales = [.25, 1.6];
		doc[addEvent](type, fix, true);
	}

}(document));