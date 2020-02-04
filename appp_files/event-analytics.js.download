// this file is for analytics related scripts

jQuery(document).ready(function($){

	//Mobile Hamburger
	$('#mobile-menu-button').on('click', function() {
		trackEvents( 'interaction-mobilenav', 'mobilenav', 'Hamburger Icon' );
	});

	//Site Title
	$('.header_title a').on('click', function() {
		trackEvents( 'outbound-header', $(this).attr("href"), $(this).text() );
	});

	//WUSTL Logo
	$(".bluebox-head-logo a").on('click', function() {
		trackEvents( 'outbound-header', $(this).attr("href"), 'WUSTL Logo' );
	});

	// Mobile Nav main links and dropdowns
	$("#prime-nav-mobile > li > a").on('click', function() {
		//Check if it is the toggle caret otherwise it is a link
		if ( $(this).hasClass( 'dropdown-link' ) ) {
				trackEvents( 'interaction-mobilenav', 'mobilesubnav', 'Caret' );
		} else {
				trackEvents( 'outbound-mobilenav', $(this).attr("href"), $(this).text() );
		}
	});

	//Mobile nav submenu, only on sites with dropdowns
	$("#prime-nav-mobile li ul li a").on('click', function() {
		trackEvents( 'outbound-mobilesubnav', $(this).attr("href"), $(this).text() );
	});

	//Sidebar navigation (includes mobile) of parent item
	$("ul.menu li.parent > a").on('click', function() {
		trackEvents( 'outbound-sidenav-parent', $(this).attr("href"), $(this).text() );
	});

	//Sidebar navigation (includes mobile) - includes parent above in total
	$("ul.menu li > a").on('click', function() {
		trackEvents( 'outbound-sidenav', $(this).attr("href"), $(this).text() );
	});

	//Main Nav
	$("#prime-nav > .menu-item > a").on('click', function() {
		trackEvents( 'outbound-primarynav', $(this).attr("href"), $(this).text() );
	});

	//Main Nav dropdowns
	$("#prime-nav .sub-menu .menu-item a").on('click', function() {
		trackEvents( 'outbound-primarysubnav', $(this).attr("href"), $(this).text() );
	});

	//Search
	$("#prime-nav-searchform-button").on('click', function() {
		trackEvents( 'interaction-primarynav', 'search', 'Search Icon' );
	});

	//Sliders
	$(".slide-details .prev-next-links a").on('click', function() {
		trackEvents( 'interaction-slider', 'slider', 'Slider Navigation' );
	});

	//Slider CTA
	$(".slide-details a.bluebox-button").on('click', function() {
		trackEvents( 'outbound-slider', $(this).attr("href"), $(this).text() );
	});
});

var trackEvents = function( category, action, label ) {
	if ( category.substring(0, 8) == 'outbound' ) {
		category += isInternal(action);
	}

	// Yoast uses global __gaTracker() function instead of standard ga()
	// https://wordpress.org/support/topic/note-change-of-global-function-ga-_gatracker
	if ( typeof __gaTracker == 'function' ) {
		__gaTracker( 'send', 'event', category, action, label );
	} else if ( typeof ga == 'function' ) {
		ga( 'send', 'event', category, action, label );
	} else if ( typeof gaplusu == 'function' ) { // Check if this is CampusPress, if so, fire an event for both the global and single UA accounts
		gaplusu( 'send', 'event', category, action, label );
		gaplusu( 'single.send', 'event', category, action, label );
	} else if (window.console){
		console.log( 'no analytics detected' );
	}

};

var isInternal = function(href) {
	var int_flag = '';
  var l = document.createElement("a");
  l.href = href;

	if ( l.hostname == window.location.hostname || l.hostname === '' ) {
  	int_flag = '-int';
  }

	return int_flag;
};
