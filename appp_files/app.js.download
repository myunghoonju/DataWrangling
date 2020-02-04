// All site specific scripts that are needed. Loads in the footer.

jQuery(document).ready(function($){
	if (!Modernizr.svg) {
		// replace all svg files in the html with their png counterpart
		$('img[src*="svg"]').attr('src', function() {
			return $(this).attr('src').replace('.svg', '.png');
		});
	}

	// run fit-vids script
	$(".main-content").fitVids({
		customSelector: 'iframe[src*="livestream.com"], iframe[src*="ustream.tv"]'
	});

	/*
	 * Hammer.js does not support IE8, but we do. Thus the source code uses various
	 * modern javascript features that are not supported by IE8 which causes the
	 * script to crash. I will use Object.keys() since that is something which
	 * hammmer.js depends on which is not supported by IE8.
	 */
	if (window.Object.keys) {
		var hammerScript = document.createElement('script');
		hammerScript.type = "text/javascript";
		hammerScript.src = "/wp-content/themes/wutheme_hoyt/app/assets/js/jquery.hammer.min.js";
		document.body.appendChild(hammerScript);
	}
});
