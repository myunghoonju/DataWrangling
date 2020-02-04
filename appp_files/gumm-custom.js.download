(function( $ ){
$(window).load(function(){
    $('.flex-slider').each(function(i, ele){
        if ($(ele).data('direction-nav-container') !== undefined && $(ele).data('direction-nav-container')) {
            var theDirectionNavContainer = $($(ele).data('direction-nav-container'));
            if (theDirectionNavContainer.length > 0) {
                theDirectionNavContainer.children().on('click', function(e){
                    e.preventDefault();
                    var slider = $(ele).data('flexslider');
                    var target = ($(this).hasClass('next')) ? slider.getTarget('next') : slider.getTarget('prev');
                    slider.flexAnimate(target, true);
                });
            }
        }
        if ($(ele).data('control-nav-container') !== undefined && $(ele).data('control-nav-container')) {
            var theControlNavContainer = $($(ele).data('control-nav-container'));
            if (theControlNavContainer.length > 0) {
                var theButtons = theControlNavContainer.children();
                theButtons.on('click', function(e){
                    e.preventDefault();
                    var slider = $(ele).data('flexslider');
                    slider.flexAnimate($(this).index(), true);

                    theButtons.removeClass('current');
                    $(this).addClass('current');
                });
            }
        }

        $(ele).flexslider({
            animation: $(ele).data('animation'),
            animationSpeed: $(ele).data('animationSpeed'),
            selector: '.slides > .slide-item',
            controlNav: Boolean($(ele).data('control-nav')),
            directionNav: Boolean($(ele).data('direction-nav')),
            animationLoop: Boolean($(ele).data('animation-loop')),
            slideshow: Boolean($(ele).data('slideshow')),
            slideshowSpeed: $(ele).data('slideshow-speed'),
            smoothHeight: Boolean($(ele).data('smooth-height')),
            prevText: '',
            nextText: '',
            start: function(slider) {
                if (slider.hasClass('loading')) {
                    slider.css({height: ''});
                    slider.find('.slides').css({visibility: 'visible', opacity: 0}).animate({opacity: 1}, 550, function(){
                        slider.removeClass('loading');
                    });
                }
                if (slider.directionNav && slider.directionNav !== undefined) {
                    slider.directionNav.filter('.' + this.namespace + 'next').addClass('icon-chevron-right');
                    slider.directionNav.filter('.' + this.namespace + 'prev').addClass('icon-chevron-left');
                }
            },
            after: function(slider) {
                if (theButtons !== undefined) {
                    theButtons.removeClass('current');
                    theButtons.eq(slider.currentSlide).addClass('current');
                }
            }
        });
    });

    $('.gumm-layout-element-slider').each(function(i, ele){
        $(ele).gummLayoutElementContentSlider({
            numVisible: $(ele).data('num-visible'),
            directionalNav: $(ele).data('directional-nav')
        });
    });

    $('.wi-slider').windy({
         prevEl: '.prev',
         nextEl: '.next',
         controlNav: true
    });

    // Masonry enabled filters
    $('.gumm-layout-element-grid').gummMasonryGrid();
    // $('.filter-buttons').gummMasonryGrid();
    $('.iphone5-frame').gummContentReveal();
});

$(document).ready(function(){

    $('.iosSlider').each(function(i, ele){
        var controlButtons = $(ele).find('.iosSlider-pagination').children('li');
        var controlGroups = [];
        $(ele).find('.iosSlider-pagination').each(function(i, ele){
            controlGroups.push($(ele).children('li'));
        });
        var detailsGroups = [];
        $(ele).find('.iosSlider-details').each(function(i, ele){
            detailsGroups.push($(ele).children());
        });
        $(ele).iosSlider({
            snapToChildren: true,
    		desktopClickDrag: true,
    		infiniteSlider: true,
            navSlideSelector: controlButtons,
            navPrevSelector: $(ele).find('.prev'),
            navNextSelector: $(ele).find('.next'),
            autoSlide: $(ele).data('autoSlide') === true ? true : false,
            autoSlideTimer: $(ele).data('autoSlideTimer') !== undefined ? $(ele).data('autoSlideTimer') : 5000,
            onSliderLoaded: function() {
                $(ele)
                    .removeClass('loading')
                    .parent('.iosSliderContainer').css('height', '');

            },
            onSlideChange: function(args) {
                if (controlGroups.length > 0) {
                    $.each(controlGroups, function(i, items){
                        $(items).removeClass('current');
                        $(items).eq(args.currentSlideNumber - 1).addClass('current');
                    });
                }
                if (detailsGroups.length > 0) {
                    $.each(detailsGroups, function(i, items){
                        $(items).removeClass('active');
                        $(items).eq(args.currentSlideNumber - 1).addClass('active');
                    });
                }
            }
        });
    });

    // For accessability - slider needs to trigger when you tab through it rather than just selecting each image link
    $('.iosSlider .slider-img-link').on('focus', function () {
        var $linkElement = $(this);
        
        var $sliderInstance = $linkElement.closest('.iosSlider');
        var sliderData = $sliderInstance.data();
        var originalSliderOnChange = sliderData.args.settings.onSlideChange;
        var numberOfSlides = sliderData.iosslider.numberOfSlides;
        
        // we don't want multiple focus events messing up our code so we will use this variable as our lock
        var inTabMode = $sliderInstance.data('tabmode');
        
        var enterTabMode = function () {
            //Tabbed mode only goes forward, so we want to make sure focus is on the first element if we decide to try to tab through backwards
            if ($linkElement.index() > 0) {
                $linkElement.siblings().eq(0).focus();
                return;
            }
            
            var activeSlideNumber;

            // Temporarily update our slider to use additional settings for tabbing through it. When the slider has been cycled through these settings are then discarded again for normal tab operation
            sliderData.args.settings.tabToAdvance = true;
            sliderData.args.settings.onSlideChange = function (args) {
                originalSliderOnChange(args);

                var $activeDetails = $sliderInstance.find('.detail-item.active');
                var activeIndex = $activeDetails.index();
                
                if (typeof activeSlideNumber === "undefined") {
                    activeSlideNumber =  activeIndex + 1;
                }
                else {
                    activeSlideNumber++;
                }
                
                // we need to end on the first slide again so this works more than once on a page
                // the iosSlider('update') function will reset the slide indexes, so we want to make sure we keep the indexes the same by only calling it when we are showing the first slide
                if (activeSlideNumber > numberOfSlides) {
                    exitTabMode();
                    return;
                }
                
                // set focus on the current element, do not do this at the end so we are not stuck in a loop
                $linkElement
                    .parent().children()
                    .eq(activeIndex)
                    .focus();
            };

            $sliderInstance.data('tabmode', true);
            $sliderInstance.iosSlider('update');
        };

        var exitTabMode = function () {
            // Put everything back the way we found it
            sliderData.iosslider.settings.tabToAdvance = false;
            sliderData.args.settings.onSlideChange = originalSliderOnChange;
            $sliderInstance.data('args', sliderData.args);
            $sliderInstance.data('iosslider', sliderData.iosslider);
            $sliderInstance.data('tabmode', false);

            // Call update async.  The slider is often still animating the last slide when update is called which stops the animation short.  We want to let that finish up first before update is called.
            setTimeout(function () {
                $sliderInstance.iosSlider('update');
            }, 0);
        };

        if (!inTabMode) {          
            enterTabMode();
        }
    });

    $('.flex-slider').each(function(i, ele){
        $(ele).height($(ele).height());
    });

    // $('#prime-nav').gummPointerMenu();
    $('#mobile-menu').gummMobileMenu();
    $('.bluebox-accordion').each(function (i, el) {
        var $el = $(el);
        
        // Open up the first element which as been designated with the 'active' flag in the shortcode 
        var activeValue = (function () {
                var $accordionHeadingCollection = $el.find('h4');
                var activeElement = $el.find('h4.ui-state-active');
                var activeIndex = $accordionHeadingCollection.index(activeElement);

                if (activeIndex === -1){
                    return false;
                }
                else{
                    return activeIndex;
                }
            })();

        $el.accordion({
            heightStyle: 'content',
            collapsible: true,
            active: activeValue,
            beforeActivate: function(event, ui){
                ui.oldHeader.find('.accordion-button').removeClass('icon-minus').addClass('icon-plus');
                ui.newHeader.find('.accordion-button').removeClass('icon-plus').addClass('icon-minus');
            }
        });
    });
    $('.tooltip-link').tooltip();
    $('.sliding-content-element').gummStepsContent();
    $('.terms-scroll-layout').gummTermsScroller();
    $('.widget-body.gumm-events-calendar-widget').gummCalendarWidget();
    $('.bb-gauge-chart').gummGaugeChart();
    if (!isMobile.any()) {
        $("a[rel^='prettyPhoto']").prettyPhoto();
    } else {
        $("a[rel^='prettyPhoto']").on('click', function(e){
           e.preventDefault();
        });
    }

    // Initialize the GummScrollr widget
    new $.gummScrollr();

    bindPopoverItems($('.gumm-events-calendar td.event a.b-popover'));
    bindPopoverItems($('.loop-categories a.b-popover, .line-meta-details a.b-popover'));
    $(document).on('click', function(e){
        _gummHideActivePopups();
    });

    // Scroll Top Link
    $('#footer-scroll-top-link').on('click', function(e){
        e.preventDefault();
    	$('html, body').stop().animate({
    	    scrollTop:0
    	}, 400);
    });

    // Bind the search form autocomplete
    $('#prime-nav-searchform .search-form .bluebox-search-input').gummAutocomplete();

    // And the menu search button});
    $('#prime-nav-searchform .bluebox-search-input').attr('onfocus', '').attr('onblur', '').val('');
    $('a#prime-nav-searchform-button').on('click', function(e){
        e.preventDefault();
        
        var $self = $(this);
        var $iconElement = $self.find('.icon-search, .icon-remove');
        
        if ($iconElement.hasClass('icon-search')) {
            $iconElement
                .removeClass('icon-search')
                .addClass('icon-remove');
            $self.addClass('prime-nav-searchform-button-active');

            $('div#prime-nav-searchform').addClass('active');
            $self.next().children().children('input.bluebox-search-input').focus();
        } else {
            $iconElement
                .removeClass('icon-remove')
                .addClass('icon-search');
            $self.removeClass('prime-nav-searchform-button-active');
            $('div#prime-nav-searchform').removeClass('active');
        }
    });
    $(document).on('click', function(e){
        // Hide search menu if you click outside of it
        if ($('div#prime-nav-searchform').hasClass('active')) {
            var target = $(e.target);
            if (!target.is('#prime-nav-searchform-button') &&
                !target.parent().is('#prime-nav-searchform-button') &&
                !target.parent().parent().is('#prime-nav-searchform') &&
                !target.parent().is('#prime-nav-searchform')
            ) {
                $('a#prime-nav-searchform-button')
                    .removeClass('prime-nav-searchform-button-active')
                    .find('.icon-remove')
                    .removeClass('icon-remove')
                    .addClass('icon-search');

                $('div#prime-nav-searchform').removeClass('active');
            }
        }
    });

    // And also... some really similar functions for the mobile search;
    $('#mobile-searchform-page .search-form .bluebox-search-input').gummMobileAutocomplete();
    $('a#mobile-searchform-button').on('click', function(e){
        e.preventDefault();
        $('div#mobile-searchform-page').addClass('active');
        $('input.bluebox-search-input').focus();
        $('html').css({"overflow":"hidden"});
        $('html').css({"height":"100%"});
        $('body').css({"overflow":"hidden"});
        $('body').css({"height":"100%"});
    });
    $('a#close-mobile-searchform').on('click', function(e){
        e.preventDefault();
        $('div#mobile-searchform-page').removeClass('active');
        $('html').removeAttr('style');
        $('body').removeAttr('style');
    });
    $('a#clear-mobile-searchform').on('click', function(e){
        e.preventDefault();
        $('input.bluebox-search-input').val("");
        $('.mobile-searchresults h2').html('');
        $('input.bluebox-search-input').focus();
    });
    $(document).on('click', function(e){
    /*
        if ($('div#mobile-searchform-page').hasClass('active')) {
            var target = $(e.target);
            if (!target.is('#mobile-searchform-button') &&
                !target.parent().parent().is('#mobile-searchform-page') &&
                !target.parent().is('#mobile-searchform-page')
            ) {
                $('a#mobile-searchform-button')
                    .removeClass('icon-remove mobile-searchform-button-active')
                    // .addClass('icon-search');

                $('div#mobile-searchform-page').removeClass('active');
            }
        }
    */
    });




    $('.json-load-more').on('click', function(e){
        var _this = $(this);
        var originText = _this.data('origintext') ? _this.data('origintext') : _this.text();
        var loadingText = _this.data('loadingtext') ? _this.data('loadingtext'): originText;
        var itemSelector = _this.data('itemselector') ? _this.data('itemselector') : '.hentry';

        var loadingLabel = _this.attr('data-loadingtext')
        e.preventDefault();
        $.ajax({
            url: $(this).attr('href'),
            beforeSend: function(jqXHR, settings) {
                _this.text(loadingText);
            },
            complete: function(jqXHR, textStatus) {
                _this.text(originText);
            },
            success: function(data, textStatus, jqXHR) {
                var items = $(data).find(itemSelector);
                items.hide();
                _this.before(items);
                items.show('fade', 350);

                var newLoadMoreLink = $(data).find('.json-load-more');
                if (newLoadMoreLink.size() > 0) {
                    _this.attr('href', newLoadMoreLink.attr('href'));
                } else {
                    _this.hide();
                }
            }
        });
    });

    // Shortcodes
    $('div.msg a.close').on('click', function(e){
        e.preventDefault();
        $(this).parent().hide('fade', 150, function(){
            $(this).remove();
        });
    });

    // Contact form sending
    $('.gumm-contact-submit').on('click', function(e){
        e.preventDefault();
        if ($(this).hasClass('action-sending')) return false;

        var theInputButton = $(this);
        var theForm = $(this).parent().parent('form');
        var theContainerId = theForm.parent().attr('id');
        $.ajax({
            url: theForm.attr('action'),
            type: 'post',
            data: theForm.serialize(),
            beforeSend: function() {
                theInputButton
                    .addClass('action-sending')
                    .val(theInputButton.data('action-title'));
            },
            success: function(data, textStatus, jqXHR) {
                var theContainer = $(data).find('#' + theContainerId);
                var theMsg = theContainer.children('.email-sent-msg');

                $('#' + theContainerId).find('.contact-form-inputs').html(theContainer.find('.contact-form-inputs').html());

                if (theMsg.length >= 1) {
                    theInputButton.after('<p class="email-sent">' + theMsg.children('p').html() + '</p>');
                    setTimeout(function(){
                        theInputButton.children('p.email-sent').hide('fade', 250);
                    }, 3000);
                }
            },
            complete: function() {
                theInputButton
                    .removeClass('action-sending')
                    .val(theInputButton.data('title'));
            }
        });
    });

    $(document).on('focus', '.labeled-input', function(e){
        if ($(this).val() === $(this).data('default-label')) {
            $(this).val('').removeClass('default-label-on');
        }
    });
    $(document).on('blur', '.labeled-input', function(e){
        if ($(this).val() === $(this).data('default-label')) {
            $(this).addClass('default-label-on');
        } else if ($(this).val().length < 1) {
            $(this).val($(this).data('default-label')).addClass('default-label-on');
        }
    });
    $(document).on('keyup', '.form-error', function(e){
        $(this).removeClass('form-error');
        $(this).next('.error').hide('fade', 250, function(){
            $(this).remove();
        })
    });

    /* Ajax Setup */
    $.ajaxSetup({
        beforeSend: function(){
            initAjaxLoad();
        },
        success: function(){
            completeAjaxLoad();
        },
        complete: function() {
            completeAjaxLoad();
        }, error: function() {
            completeAjaxLoad();
        }
    });

    function initAjaxLoad() {
        $('body').addClass('ajaxloading');
    }
    function completeAjaxLoad() {
        $('body').removeClass('ajaxloading');
    }

});

// Generic
window.bindPopoverItems = function(popoverItems) {
    popoverItems.popover({
        trigger: 'manual',
        placement: 'top'
    });
    popoverItems.on('click', function(e){
        e.preventDefault();
        e.stopPropagation();

        if ( ($('html').width() - $(this).offset().left + $(this).outerWidth()) < 250 ) {
            $(this).popover('destroy');
            $(this).popover({
                trigger: 'manual',
                placement: 'left'
            });
        } else if ($(this).offset().left < 50) {
            $(this).popover('destroy');
            $(this).popover({
                trigger: 'manual',
                placement: 'right'
            });
        }
        $(this).popover('toggle');
        var $tip = $(this).data('popover').$tip;
        _gummHideActivePopups($tip);
        if (!$tip) $tip = $(this).data('popover').$tip;

        if (!$tip.hasClass('event-calendar-popover')) {
            $tip.addClass('event-calendar-popover');
        }

        $(this).data('_gummBootstrapPopover.$tip', $tip);
        $tip.data('_gummBootstrapPopover.$reltarget', $(this));
        $tip.find('*').on('click', function(e){e.stopPropagation();});
    });
}

window._gummHideActivePopups = function(exclude) {
    $('.popover').each(function(i, ele){
        if ($(ele).is($(exclude))) return;
        var popTarget = $(ele).data('_gummBootstrapPopover.$reltarget')
        if ($(popTarget).size() > 0) {
            $(popTarget).popover('hide');
        }
    });
}

window.isMobile = {
    Android: function() {
        return navigator.userAgent.match(/Android/i);
    },
    BlackBerry: function() {
        return navigator.userAgent.match(/BlackBerry/i);
    },
    iOS: function() {
        return navigator.userAgent.match(/iPhone|iPad|iPod/i);
    },
    Opera: function() {
        return navigator.userAgent.match(/Opera Mini/i);
    },
    Windows: function() {
        return navigator.userAgent.match(/IEMobile/i);
    },
    any: function() {
        return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
    }
};

})( jQuery );

(function($) {

    // BEGIN GUMM SCROLLR
    $.gummScrollr = function gummScrollr(options, callback) {
        this.__construct(options);
    }

    $.gummScrollr.settings = {
        items: '.gumm-scrollr-item',
        inactiveClass: 'not-initialized'
    }

    $.gummScrollr.prototype = {
        offsets: [],
        initialized: false,
        windowScrollTop: null,
        allInitialized: false,
        scrollEventCallback: null,
        initializedOffsets: [],
        __construct: function(options) {
            this.options = $.extend(true, {}, $.gummScrollr.settings, options);
            this.items = $(this.options.items);

            this.bindListeners();
        },
        __destruct: function() {
            $(window).unbind('scroll', this.scrollEventCallback);
        },
        initialize: function() {
            this.initialized = true;
            this.calculatePositions();
            this.unhideHidden();
        },
        calculatePositions: function() {
            var _self = this;
            this.items.each(function(i, ele){
                _self.offsets.push($(ele).offset().top + ($(ele).height()/2));
            });
        },
        unhideHidden: function() {
            if (!this.initialized) return false;
            var _self = this;
            var scrollBottom = this.getScrollBottom();
            for (var i=0; i<this.offsets.length; i++) {
                if (this.initializedOffsets[i] === true) continue;
                var _offset = this.offsets[i];
                if (_offset < (scrollBottom - 50)) {
                    this.initializedOffsets[i] = true;
                    setTimeout(function(i){
                        _self.items.eq(i).removeClass(_self.options.inactiveClass).trigger('gummScrollred');
                    }, 300, i);


                    if (this.initializedOffsets.length === this.offsets.length) {
                        this.allInitialized = true;
                        this.__destruct();
                    }
                }
            }
        },
        getScrollBottom: function() {
            return $(window).scrollTop() + $(window).height();
        },
        bindListeners: function() {
            var _self = this;
            this.scrollEventCallback = function() {
                _self.unhideHidden();
            }
            $(window).on('scroll', this.scrollEventCallback);
            $(window).on('load', function(e){
                setTimeout(function(){
                    _self.initialize();
                }, 10);
            });
        }
    }

    // BEGIN GUMM FILTERABLE ITEMS

    $.gummMasonryGrid = function gummMasonryGrid(options, callback, element) {
        this.element = $(element);
        this.__construct(options, callback);
    }

    $.gummMasonryGrid.settings = {

    }

    $.gummMasonryGrid.prototype = {
        __construct: function(options, callback) {
            this.buttonsContainer   = this.element.find('.filter-buttons');
            this.buttons            = this.buttonsContainer.children();
            this.itemsContainer     = this.element.find('.grid-container');
            this.items              = this.itemsContainer.find('.grid-item');
            this._categoryIds       = {};
            this.currentIndex       = 0;

            var _self = this;
            this.buttons.each(function(i, ele){
                var catId = /cat-item\-(\d+)/g.exec($(ele).attr('class'));
                if (catId !== null) {
                    catId = parseInt(catId[1]);
                } else {
                    catId = false;
                }

                _self._categoryIds[i] = catId;
            });

            this.itemsContainer.css({
            // $('.portfolio-layout-element .gumm-filterable-item').css({
                position: 'relative'
            });
            this.itemsContainer.children('.row-fluid').css({
            // $('.portfolio-layout-element .row-fluid.portfolio-cols').css({
                position: 'static',
                margin: 0
            });
            this.itemsContainer.find('.grid-item').each(function(i, ele){
            // $('.portfolio-layout-element .gumm-filterable-items').find('.gumm-filterable-item').each(function(i, ele){
                var $ele = $(ele);
                $ele.css({
                    marginLeft: 0,
                    marginBottom: 15
                });

            });

            this.itemsContainer.prepend('<div class="gutter-sizer" style="width: 2.127659574468085%">');

            this.itemsContainer.masonry({
                itemSelector: '.grid-item',
                gutter: '.gutter-sizer'
            });
            this.Masonry        = Masonry.data(this.itemsContainer.get(0));
            this.masonryItems   = this.Masonry.items;

            this.bindListeners();
        },
        bindListeners: function() {
            var _self = this;

            this.buttons.on('click', function(e){
                e.preventDefault();
                e.stopPropagation();

                var $this = $(this);

                var thisIndex = $this.index();

                if (thisIndex === _self.currentIndex) {
                    return;
                }
                _self.currentIndex = thisIndex;

                _self.buttons.removeClass('current');
                $(this).addClass('current');

                var catId = _self._categoryIds[$(this).index()];

                var masonryItems = [];
                var clonedItems  = _self.masonryItems.slice(0);

                var itemsLength = clonedItems.length;

                if (catId !== false && catId !== 0) {
                    for (i=0; i<itemsLength; i++) {
                        var item = $(_self.masonryItems[i].element);

                        if (item.hasClass('for-category-' + catId)) {
                            masonryItems.push(clonedItems[i]);
                            item.addClass('active').removeClass('inactive');
                        } else {
                            item.addClass('inactive').removeClass('active');
                        }
                    }
                } else {
                    masonryItems = _self.masonryItems;
                    _self.items.addClass('active').removeClass('inactive');
                }

                _self.Masonry.items = masonryItems;
                _self.itemsContainer.masonry('layout');

            });
        }
    }

    $.fn.gummMasonryGrid = function gummMasonryGridFn(options, callback) {
        this.each(function () {
            var instance = $.data(this, 'gummMasonryGrid');
            if (instance) {
                // update options of current instance
                // instance.update(options);
            } else {
                $.data(this, 'gummMasonryGrid', new $.gummMasonryGrid(options, callback, this));
            }

        });
        return this;
    }

    // END GUMM FILTERABLE ITEMS

    // BEGIN GUMM LAYOUT ELEMENT SLIDER

    $.gummLayoutElementContentSlider = function gummLayoutElementContentSlider(options, callback, element) {
        this.element = $(element);
        this.__construct(options, callback);
    }

    $.gummLayoutElementContentSlider.settings = {
        directionalNav: '.nav-arrows',
        slidesContainer: '.slides-container',
        items: 'div',
        elementMargin: null,
        numVisible: 3
    }

    $.gummLayoutElementContentSlider.prototype = {
        duringAnimation: false,
        __construct: function(options, callback) {
            this.options = $.extend(true, {}, $.gummLayoutElementContentSlider.settings, options);

            this.directionalNav = this.element.find(this.options.directionalNav);
            this.prevButton = this.directionalNav.children('.prev');
            this.nextButton = this.directionalNav.children('.next');

            this.slidesContainer = this.element.find(this.options.slidesContainer);

            if (!this.options.elementMargin) {
                this.options.elementMargin = parseFloat(this.slidesContainer.children(':visible').eq(1).css('marginLeft'));
            }

            // this.firstIndex = 0;
            // this.lastIndex = this.options.numVisible - 1;

            this.initHtml();
            // this.initItems();

            this.bindListeners();
        },
        initHtml: function() {
            this.slidesContainer.wrap('<div class="slides-container-wrapper" />');
            this.slidesContainer.wrap('<div class="slides-container-wrap" />');
        },
        initItems: function() {
            var _self = this;
            this.items = this.slidesContainer.children(this.options.items);
            this.items.css({position: 'relative'});
            this.items.each(function(i, ele){
                var item = $(ele);
                if (i >= _self.options.numVisible) {
                    item.removeClass('hidden').css({
                        display: 'none'
                        // left: '100%',
                        // position: 'absolute'
                    });

                }
            });
        },
        next: function() {
            if (this.duringAnimation) return;
            this.duringAnimation = true;
            var _self = this;
            var visibleItems = this.slidesContainer.children(':visible');
            var firstItem = visibleItems.eq(0);
            var secondItem = visibleItems.eq(1);
            var lastItem = visibleItems.eq((this.options.numVisible - 1));
            var newItem = lastItem.next();

            newItem.css({
                position: 'absolute',
                top: 0,
                display: 'block',
                // opacity: 1,
                left: lastItem.position().left + lastItem.width() + parseFloat(lastItem.css('marginLeft'))
            }).removeClass('hidden');

            secondItem.animate({
                marginLeft: 0
            }, 150, 'easeInQuart', function(){
                if (newItem.size() < 1) {
                    secondItem.animate({
                        marginLeft: _self.options.elementMargin
                    }, 100, function(){
                        _self.duringAnimation = false;
                    });
                } else {
                    var width = firstItem.width();
                    newItem.animate({
                        left: newItem.position().left - width
                    }, 250, 'linear', function(){
                        newItem.css({
                            left: '',
                            position: 'relative'
                        });
                    });
                    firstItem.animate({
                        marginLeft: -width
                    }, 250, 'linear', function(){
                        firstItem.hide();
                        _self.duringAnimation = false;
                    });
                }
            });

        },
        prev: function() {
            if (this.duringAnimation) return;
            this.duringAnimation = true;
            var _self = this;
            var visibleItems = this.slidesContainer.children(':visible');
            var firstItem = visibleItems.eq(0);
            var secondItem = visibleItems.eq(1);
            var lastItem = visibleItems.eq((this.options.numVisible - 1));
            var newItem = firstItem.prev();

            lastItem.css({
                top: 0,
                left: lastItem.position().left,
                position: 'absolute'
            });

            firstItem.animate({
                marginLeft: _self.options.elementMargin
            }, 150, 'easeInQuart', function(){
                if (newItem.size() < 1) {

                    firstItem.animate({
                        marginLeft: 0
                    }, 100, function(){
                        lastItem.css({
                            left: 'auto',
                            position: 'relative'
                        });
                        _self.duringAnimation = false;
                    });
                } else {
                    lastItem.animate({
                        left: lastItem.position().left + (lastItem.width())
                    }, 250);

                    newItem.css({
                        display: 'block'
                        // opacity: 1
                    }).animate({
                        marginLeft: 0
                    }, 250, function(){
                        lastItem.css({
                            display: 'none',
                            position: 'relative'
                        });
                        _self.duringAnimation = false;
                    });
                }

            });
        },
        bindListeners: function() {
            var _self = this;
            this.prevButton.on('click', function(e){
                e.preventDefault();
                _self.prev();
            });
            this.nextButton.on('click', function(e){
                e.preventDefault();
                _self.next();
            });
        }
    }

    $.fn.gummLayoutElementContentSlider = function gummLayoutElementContentSliderFn(options, callback) {
        this.each(function () {
            var instance = $.data(this, 'gummLayoutElementContentSlider');
            if (instance) {
                // update options of current instance
                // instance.update(options);
            } else {
                $.data(this, 'gummLayoutElementContentSlider', new $.gummLayoutElementContentSlider(options, callback, this));
            }

        });
        return this;
    }

    // END GUMM LAYOUT ELEMENT SLIDER

    // BEGIN GUMM STEPS CONTENT

    /* Steps Content Fn */
    $.gummStepsContent = function gummStepsContent(options, callback, element) {
        this.element = $(element);
        this.__construct(options, callback);
    }

    $.gummStepsContent.settings = {
        stepsContainer: '.sliding-content-steps',
        stepItems: '.rule-step',
        contentHolder: '.sliding-content-holder',
        items: '.sliding-content-entry',
        pointer: '.blog-post-pointer-detail',
        wrapper: '.rule-step-wrap',
        verticalPaddingDeviaion: 20,
        verticalPointerDeviation: 2,
        speed: 500
    }

    $.gummStepsContent.prototype = {
        wrapHeight: 0,
        current: 0,
        __construct: function(options, callback) {
            this.options = $.extend(true, {}, $.gummStepsContent.settings, options);
            this.wrapperElement = this.element.find(this.options.wrapper);
            this.items = this.element.find(this.options.items);
            this.pointer = this.element.find(this.options.pointer);
            this.container = this.element.find(this.options.contentHolder);
            this.stepsNav = this.element.find(this.options.stepsContainer);
            this.stepItems = this.stepsNav.find(this.options.stepItems);

            // this.wrapHeight = this.wrapperElement.height() - (this.options.verticalPaddingDeviaion*2);
            this.pointerHeight = this.pointer.height();
            var _stepItem = this.stepItems.eq(0);
            this.itemVerticalMargin = parseInt(_stepItem.css('marginTop')) + parseInt(_stepItem.css('marginBottom'));
            this.itemHeight = _stepItem.height() + parseInt(_stepItem.css('marginTop')) + parseInt(_stepItem.css('marginBottom'));

            this.container.height(this.wrapHeight).css({
                overflow: 'hidden',
                paddingBottom: 0,
                position: 'relative'
            });

            var _maxHeight = 0;
            var _self = this;
            this.items.each(function(i, item){
                $(item).css({
                    display: 'block',
                    opacity: 0,
                    position: 'relative',
                    float: 'left',
                    width: '100%'
                }).removeClass('hidden');

                var _itemHeight = $(item).height();
                $(item).data('originHeight', _itemHeight);
                // if (_itemHeight > _maxHeight) _maxHeight = _itemHeight;
                if (i === _self.current) _maxHeight = _itemHeight;
                $(item).css({
                    opacity: 1
                });
            });
            this.wrapHeight = _maxHeight;
            this.container.css({height: _maxHeight});

            this.bindListeners();
        },
        goTo: function(index) {
            if (this.current == index) return;
            this.stepItems.eq(this.current).removeClass('current');
            this.stepItems.eq(index).addClass('current');

            var contentToGoTo = this.items.eq(index);

            var scrollTo = 0;
            for (var i=0; i<index; i++) {
                scrollTo += this.items.eq(i).outerHeight();
            }
            this.container.animate({
                scrollTop: scrollTo,
                height: contentToGoTo.height()
            }, this.options.speed);
            this.pointerGoTo(index);
            this.current = index;
        },
        pointerGoTo: function(index) {
            this.pointer.animate({
                top: this.itemHeight*index + this.options.verticalPointerDeviation
            }, this.options.speed)
        },
        bindListeners: function() {
            var _self = this;
            this.stepItems.children('a').on('click', function(e){e.preventDefault()});
            this.stepItems.on('click', function(e){
                e.preventDefault();
                _self.goTo($(this).index());
            });
        }
    }

    $.fn.gummStepsContent = function gummStepsContentFn(options, callback) {
        this.each(function () {
            var instance = $.data(this, 'gummStepsContent');
            if (instance) {
                // update options of current instance
                // instance.update(options);
            } else {
                $.data(this, 'gummStepsContent', new $.gummStepsContent(options, callback, this));
            }

        });
        return this;
    }

    // END GUMM STEPS CONTENT

    // Calendar Widget FN

    $.gummCalendarWidget = function gummCalendarWidget(options, callback, element) {
        this.element = $(element);
        this.__construct(options, callback);
    }

    $.gummCalendarWidget.settings = {
        container: '.calendar-sheet-container',
        items: '.sheet-item',
        navigationLinks: '.next, .prev',
        header: '.month-heading',
        start: 0
    }

    $.gummCalendarWidget.prototype = {
        current: null,
        animating: false,
        __construct: function(options, callback) {
            this.options = $.extend(true, {}, $.gummCalendarWidget.settings, options);
            this.header = this.element.find(this.options.header);
            this.navigationLinks = this.element.find(this.options.navigationLinks);
            this.container = this.element.find(this.options.container);
            this.current = this.container.children(this.options.items).eq(this.options.start);

            this.current.data('month', this.header.children('h4').html());
            this.current.data('prevlink', this.navigationLinks.filter('.prev').attr('href'));
            this.current.data('nextlink', this.navigationLinks.filter('.next').attr('href'));

            this.itemWidth = this.current.width();
            this.container.height(this.container.height());

            this.calendarRows = this.container.find('tr');

            this.setupItems();


            this.header.css({
                'transform-origin': 'center top'
            });
            this.container.css({
                position: 'relative',
                overflow: 'hidden'
            });

            this.bindListeners();
        },
        setupItems: function() {
            var _self = this;
            this.container.children(this.options.items).each(function(i, ele){
                _self.setupItem($(ele));
            });
        },
        setupItem: function(item) {
            item.css({
                left: 0,
                bottom: 0,
                right: 0,
                position: 'absolute'
            });
            this.itemWidth = item.width();
            item.css({
                width: this.itemWidth
            });
        },
        getItems: function() {
            return this.container.children(this.options.items);
        },
        animate: function(dir) {
        },
        getCalendarColumns: function(rows, dir) {
            if (rows === undefined) var rows = this.calendarRows;
            var nThDaysOfWeek = [];
            var i;
            if (dir == 'prev') {
                for (i=7; i>=1; i--) {
                    var nThChildren = rows.children('td:nth-child(' + i + ')');
                    nThDaysOfWeek.push(nThChildren);
                }
            } else {
                for (i=1; i<=7; i++) {
                    var nThChildren = rows.children('td:nth-child(' + i + ')');
                    nThDaysOfWeek.push(nThChildren);
                }
            }

            return nThDaysOfWeek;
        },
        next: function() {
            if (this.animating) return;
            this.animating = true;

            var _self = this;
            var animatingItem = this.current;

            var nextItem = this.getNextItem();
        },
        prev: function() {
            if (this.animating) return;
            this.animating = true;

            var _self = this;
            var animatingItem = this.current;
            var nextItem = this.getNextItem('prev');
        },
        animateNext: function(nextItem, dir) {
            var _self = this;

            var containerLeft, currentItemsLeft, newItemsLeft;
            var elementWidth = this.element.outerWidth();
            if (dir == 'prev') {
                containerLeft = -elementWidth;
                currentItemsLeft = _self.element.outerWidth()*2;
                newItemsLeft = elementWidth;
            } else {
                containerLeft = elementWidth;
                currentItemsLeft = -_self.element.outerWidth()*2;
                newItemsLeft = -elementWidth;
            }
            newItemsLeft += 3;

            nextItem.css({
                left: containerLeft
            }).show();
            this.current.css({
                zIndex: 14
            });
            var newCols = this.getCalendarColumns(nextItem.find('tr'), dir);

            var delay = 0;
            $.each(this.getCalendarColumns(this.calendarRows, dir), function(i, column){
                var dates = column.children('a');
                dates.delay(delay).css({
                    position: 'relative'
                }).animate({
                    left: currentItemsLeft,
                    opacity: 0
                }, 800);

                delay += 50;
            });

            var _newDelay = 400;
            $.each(newCols, function(i, column){
                var dates = column.children('a');
                dates.delay(_newDelay).css({
                    position: 'relative',
                    visibility: 'visible',
                    display: 'block',
                    opacity: 1
                }).animate({
                    left: newItemsLeft
                }, 250);

                if (i+1 == newCols.length) {
                    setTimeout(function(){
                        _self.onAnimationEnd(nextItem);
                    }, (_newDelay + 350));
                }
                _newDelay += 50;
            });

        },
        onAnimationEnd: function(nextItem) {
            nextItem.css({
                left: 0,
                top: 0
            });
            this.normalizeElements(nextItem);
            this.normalizeElements(this.current);
            this.current.css({
                display: 'none',
                zIndex: 15
            });
            this.current = nextItem;
            this.calendarRows = this.current.find('tr');
            this.animating = false;
        },
        normalizeElements: function(item) {
            item.find('tr').find('a').css({
                left: 'auto',
                opacity: 1
            });
        },
        getNextItem: function(dir) {
            var _self = this;
            if (dir === undefined) var dir = 'next';
            var nextItem;
            switch(dir){
             case 'next':
                nextItem = this.current.next();
                break;
             case 'prev':
             case 'previous':
                nextItem = this.current.prev();
                break;
            }

            if (nextItem.size() < 1) {
                nextItem = this.current.clone();
                nextItem.css({
                    display: 'none',
                    opacity: 0
                });

                var dirNavSelector = '.next';
                switch(dir){
                 case 'next':
                    this.current.after(nextItem);
                    break;
                 case 'prev':
                 case 'previous':
                    dirNavSelector = '.prev';
                    this.current.before(nextItem);
                    break;
                }

                $.ajax({
                    url: this.navigationLinks.filter(dirNavSelector).attr('href'),
                    success: function(data, textStatus, jqXHR) {
                        var theContent = $(data).find(_self.options.items).html();
                        var navLinks = $(data).find(_self.options.navigationLinks);

                        var nextHref = navLinks.filter('.next').attr('href');
                        var prevHref = navLinks.filter('.prev').attr('href');
                        _self.navigationLinks.filter('.next').attr('href', nextHref);
                        _self.navigationLinks.filter('.prev').attr('href', prevHref);

                        var heading = $(data).find(_self.options.header).children('h4');
                        _self.header.children('h4').html(heading.html()).animate({
                            opacity: 1
                        }, 100);

                        nextItem.data('month', heading.html());
                        nextItem.data('prevlink', prevHref);
                        nextItem.data('nextlink', nextHref);

                        nextItem.html(theContent).animate({
                            opacity: 1
                        }, 150);

                        _self.animateNext(nextItem, dir);
                        nextItem.find('td a').on('click', function(e){ e.preventDefault(); })
                        bindPopoverItems(nextItem.find('a.b-popover'));
                    }
                });
            } else {
                // console.log(nextItem.data());
                this.header.children('h4').html(nextItem.data('month')).animate({opacity: 1}, 100);
                this.navigationLinks.filter('.next').attr('href', nextItem.data('nextlink'));
                this.navigationLinks.filter('.prev').attr('href', nextItem.data('prevlink'));
                nextItem.css({
                    opacity: 1
                });
                this.container.animate({
                    height: nextItem.outerHeight()
                }, 150);
                this.animateNext(nextItem, dir);
            }

            return nextItem;
        },
        loadNewContent: function(contentEle) {

        },
        bindListeners: function() {
            var _self = this;
            this.navigationLinks.on('click', function(e){
                e.preventDefault();
                if ($(this).hasClass('next')) {
                    _self.next();
                } else {
                    _self.prev();
                }

            });
            $(window).on('resize', function(e){
                _self.getItems().innerWidth(_self.element.width() - 8);
                _self.container.height(_self.current.height() - 6);
            });
            $(document).on('gummLayoutChanged', function(e){
                _self.getItems().innerWidth(_self.element.width() - 2);
                _self.container.height(_self.current.height());
            });
        }
    }

    $.fn.gummCalendarWidget = function gummCalendarWidgetFn(options, callback) {
        this.each(function () {
            var instance = $.data(this, 'gummCalendarWidget');
            if (instance) {
                // update options of current instance
                // instance.update(options);
            } else {
                $.data(this, 'gummCalendarWidget', new $.gummCalendarWidget(options, callback, this));
            }

        });
        return this;
    }

    $.gummPointerMenu = function gummPointerMenu(options, callback, element) {
        this.element = $(element);
        this.__construct(options, callback);
    }
    $.gummPointerMenu.settings = {
        items: 'li',
        subMenu: '.sub-menu',
        parentClass: 'sub-menu-parent',
        pointer: '.menu-pointer',
        speed: 450,
        fadeSpeed: 0,
        easing: 'easeOutBack',
        clone: true,
        cloneClass: 'current-menu-pointer',
        selectedClass: 'current-menu-item',
        navCollapseTrigger: '#button-nav-collapse-trigger',
        navCollapse: '#nav-collapse',
        timeout: 600,
        subMenuTimeout: 150
    }
    $.gummPointerMenu.prototype = {
        element: null,
        pointer: null,
        items: null,
        selectedItem: null,
        mouseoutTimeOut: null,
        submenuMouseoutTimeOut: null,
        activeSubMenu: null,
        __construct: function(options, callback) {
            this.options = $.extend(true, {}, $.gummPointerMenu.settings, options);
            this.pointer = this.element.find(this.options.pointer + ':first');
            var pointerVisible = this.element.find(this.options.pointer + ':visible').eq(0);
            if (pointerVisible.size() > 0) {
                this.selectedItem = pointerVisible.parents(this.options.items + ':first');
                // this.move(this.selectedItem);
                if (this.options.clone) {
                    var pointerClone = pointerVisible;
                    if (pointerVisible.is(this.pointer)) {
                        pointerClone = this.pointer.clone();
                        this.pointer.after(pointerClone);
                    }
                    pointerClone.addClass(this.options.cloneClass);
                } else {
                    if (!pointerVisible.is(this.pointer)) pointerVisible.hide();
                }
            }
            this.navCollapseTrigger = $(this.options.navCollapseTrigger);
            this.navCollapse = $(this.options.navCollapse);
            var _self = this;

            this.items = this.element.find(this.options.items);

            this.items.each(function(i, ele){
                // $(ele).css({position: 'relative'});
                _self._initParentItemClass($(ele));
            });
            this._initSubmenuItemsPositions();
            this._bindListeners();

        },
        _initParentItemClass: function(item) {
            item.css({
                position: 'relative'
            });
            var _self = this;
            var subMenuItem = $(item).children(this.options.subMenu);
            if (subMenuItem.size() > 0) {
                $(item).addClass(this.options.parentClass);
                subMenuItem.children(this.options.items).each(function(i, ele){
                    _self._initParentItemClass($(ele));
                });
            }
        },
        _initSubmenuItemsPositions: function() {
            var documentWidth = $(document).width();
            var subMenuItems = this.element.find(this.options.subMenu);
            var _self = this;
            subMenuItems.each(function(i, item){
                $(item).css({
                    opacity: 0,
                    display: 'block',
                    visibility: 'visible'
                });
                var itemParent = $(item).parent();
                if (!itemParent.parent().is(_self.element)) {
                    // $(item).css({
                    //     left: itemParent.outerWidth() - 2,
                    //     top: 0
                    // });
                    itemParent.addClass('dropdown-submenu');
                }
                var rightPos = $(item).offset().left + $(item).outerWidth();
                if (rightPos > documentWidth) {
                    // $(item).css({
                    //     left: -itemParent.outerWidth()
                    // });
                }
            });
            subMenuItems.css({display: 'none'});
        },
        move: function(ele) {
            var speed = this.options.speed;
            if (this.pointer.is(':hidden') && this.selectedItem) {
                this.pointer.css({
                    left: this.selectedItem.position().left,
                    width: this.selectedItem.width()
                });
            } else if (this.pointer.is(':hidden') && !this.selectedItem) {
                speed = 0;
            }

            this.pointer.show().dequeue().animate({
                left: ele.position().left,
                width: ele.width()
            }, speed, this.options.easing);


        },
        openSubmenu: function(ele) {
            if (ele.parent().is(this.element)) {
                ele.addClass('hovered');
            }
            var subMenuItem = ele.children(this.options.subMenu);
            if  (subMenuItem.size() < 1) return false;
            else if (subMenuItem.data('gummOpened') === true) return false;

            subMenuItem.css({display: 'block'}).data('gummOpened', true);

            var documentWidth = $(document).width();
            var rightPos = $(subMenuItem).offset().left + $(subMenuItem).outerWidth();
            if (rightPos > documentWidth && !ele.parent().is(this.element)) {
                $(subMenuItem).css({
                    left: '-100%'
                });
            }
            subMenuItem.stop().animate({
                opacity: 1
            }, this.options.fadeSpeed);

            return true;
        },
        closeSubmenu: function(ele) {
            if (ele.parent().is(this.element)) {
                ele.removeClass('hovered');
            }
            var subMenuItem = ele.children(this.options.subMenu);
            if (subMenuItem.size() < 1) return false;

            subMenuItem.data('gummOpened', false);
            subMenuItem.stop().animate({
                opacity: 0
            }, this.options.fadeSpeed, function() {
                $(this).css({display: 'none'});
            });

            return true;
        },
        _bindListeners: function() {
            var _self = this;
            if (!Modernizr.touch) {
                this.items.bind('mouseenter', function(e){
                    var timeoutDur = _self.options.subMenuTimeout;
                    if ($(this).parent().is(_self.element)) {
                        _self.move($(this));
                        // timeoutDur = 0;
                    }
                    var item = $(this);

                    if (item.data('gummPointerMenuCloseTO') !== undefined) {
                        clearTimeout(item.data('gummPointerMenuCloseTO'));
                    }
                    item.data('gummPointerMenuOpenTO', setTimeout(function(){
                        _self.openSubmenu(item);
                    }, timeoutDur));

                });
                this.items.bind('mouseleave', function(e){
                    var item = $(this);
                    var timeoutDur = _self.options.subMenuTimeout;
                    if ($(this).parent().is(_self.element)) {
                        // timeoutDur = 0;
                    }
                    if (item.data('gummPointerMenuOpenTO') !== undefined) {
                        clearTimeout(item.data('gummPointerMenuOpenTO'));
                    }
                    item.data('gummPointerMenuCloseTO', setTimeout(function(){
                        _self.closeSubmenu(item);
                    }, timeoutDur));
                });
                this.element.bind('mouseenter', function(e){
                    clearTimeout(_self.mouseoutTimeOut);
                });
                this.element.bind('mouseleave', function(e){
                    _self.mouseoutTimeOut = setTimeout(function(){
                        if (!_self.selectedItem) {
                            _self.pointer.hide();
                        } else {
                            _self.move(_self.selectedItem);
                        }
                    }, _self.options.timeout);
                });
            } else {
                this.items.on('click', function(e){
                    var currTimestamp = e.timeStamp;
                    var lastTimestamp = $(this).data('gummOpenTimestamp');

                    if (_self.openSubmenu($(this)) === true) {
                        $(this).data('gummOpenTimestamp', e.timeStamp);
                        e.preventDefault();
                    } else if (lastTimestamp !== undefined && lastTimestamp !== false) {
                        var timestampDiffInSeconds = (currTimestamp - lastTimestamp) / 1000;
                        if (timestampDiffInSeconds > 5) {
                            e.preventDefault();
                            _self.closeSubmenu($(this));
                            $(this).data('gummOpenTimestamp', false);
                        }
                    }
                });
            }
            // Custom nav collapse as bootstrap's kind of ... well u know
            this.navCollapseTrigger.on('click', function(e){
                if (_self.navCollapse.data('gummOpened') === true) {
                    _self.navCollapse.stop().animate({
                        height: 0
                    }, 350, function() {
                        $(this).data('gummOpened', false);
                    });
                } else {
                    _self.navCollapse.stop().animate({
                        height: _self.element.outerHeight()
                    }, 350, function(){
                        $(this).css({
                            height: 'auto'
                        }).data('gummOpened', true);
                    });
                }
            });

        }
    }
    $.fn.gummPointerMenu = function initGummPointerMenu(options, callback) {
        this.each(function () {
            var instance = $.data(this, 'gummPointerMenu');
            if (instance) {
                // update options of current instance
                // instance.update(options);
            } else {
                $.data(this, 'gummPointerMenu', new $.gummPointerMenu(options, callback, this));
            }

        });
        return this;
    }

    // RESPONSIVE MENU FN
    $.gummMobileMenu = function gummMobileMenu(options, callback, element) {
        this.element = $(element);
        this.__construct(options, callback);
    }

    $.gummMobileMenu.settings = {
        button: '#mobile-menu-button',
        wrap: '#bluebox-wrap',
        menu: '#mobile-menu',
        items: 'li',
        subMenuItems: 'ul.sub-menu',
        dropdownLink: '.dropdown-link',
        dropDownClassOpen: 'icon-caret-down',
        dropDownClassClose: 'icon-caret-up'
    }

    $.gummMobileMenu.prototype = {
        state: 'closed',
        __construct: function(options, callback) {
            this.options = $.extend(true, {}, $.gummMobileMenu.settings, options);
            this.button = $(this.options.button);
            this.wrap = $(this.options.wrap);
            this.items = this.element.find(this.options.items);
            this.dropdownButtons = this.items.find(this.options.dropdownLink);
            this.menu = $(this.options.menu);

            // this.menu.css({
            //     visibility: 'visible',
            //     display: 'none',
            //     opacity: 0
            // });
            this.bindListeners();
        },
        setSubemuDataHeight: function(submenuItem) {
            submenuItem.css({display: 'block', 'height': 'auto'});
            submenuItem.data('height', submenuItem.outerHeight());
        },
        open: function() {
            // if (!$('body').hasClass('mobile-menu-initialized')) {
            //     $('body').addClass('mobile-menu-initialized');
            // }
            var _self = this;
            // $('body').addClass('mobile-menu-active');
            this.menu.css({
                // opacity: 1,
                display: 'block'
            });
            this.wrap.transit({
                x: 250
            }, 500, function(){
                // console.log('yeah');
                _self.menu.css({
                    zIndex:0
                });
            });
            this.state = 'opened';
        },
        close: function() {
            var _self = this;

            this.menu.css({
                zIndex:-1
            });
            this.wrap.transit({
                x: 0
            }, 500, function(){
                _self.menu.css({
                    display: 'none'
                });
            });
            this.state = 'closed';
        },
        bindListeners: function() {
            var _self = this;
            this.button.on('click', function(e){
                e.preventDefault();
                if (_self.state === 'closed') {
                    _self.open();
                    // _self.menu.css({
                    //     opacity: 1,
                    //     display: 'block'
                    // });
                    // _self.wrap.transit({
                    //     x: 250
                    // }, 500);
                    // _self.state = 'opened';
                } else {
                    _self.close();
                    // _self.wrap.transit({
                    //     x: 0
                    // }, 500, function(){
                    //     _self.menu.css({
                    //         opacity: 0,
                    //         display: 'none'
                    //     });
                    // });
                    // _self.state = 'closed';
                }
            });
            this.dropdownButtons.on('click', function(e){
                e.preventDefault();
                var $self = $(this);
                
                if ($self.hasClass('open')) {
                    $self.find('[class^=icon-caret]')
                            .removeClass(_self.options.dropDownClassClose)
                            .addClass(_self.options.dropDownClassOpen);
                    var submenuItem = $self.parent().children(_self.options.subMenuItems);
                    submenuItem.removeClass('dropdown-state-open').addClass('dropdown-state-close');
                    //.css({
                        // height: 0
                    // });
                    // $(this).parent().children(_self.options.subMenuItems).hide().animate({
                    //     height: 0
                    // }, 500);
                    submenuItem.slideUp(400, 'easeInOutExpo');
                    $self.removeClass('open');
                } else {
                    $self.find('[class^=icon-caret]')
                            .removeClass(_self.options.dropDownClassOpen)
                            .addClass(_self.options.dropDownClassClose);
                    var submenuItem = $self.parent().children(_self.options.subMenuItems);
                    submenuItem.slideDown(400, 'easeInOutExpo');
                    submenuItem.addClass('dropdown-state-open').addClass('dropdown-state-open');
                    $self.addClass('open');
                    //.css({
                        // height: submenuItem.data('height')
                    // });

                    // console.log(submenuItem.data('height'));
                    // submenuItem.show().animate({
                    //     height: submenuItem.data('height')
                    // }, 500, 'easeInOutExpo');
                }
            });

            // Some touch events thanks to hammer.js
            try {
                if (Modernizr.touch) {
                    this.wrap.hammer({
                        drag: false,
                        hold: false,
                        release: false,
                        swipe: true,
                        swipe_velocity: .5,
                        tap: false,
                        touch: false,
                        transform: false,
                        prevent_mouseevents: false
                    }).on('swiperight', function(e){
                        if (!$(e.target).hasClass('swipe-item')) {
                            e.preventDefault();
                            e.stopPropagation();
                            e.stopImmediatePropagation();
                            _self.open();
                        }
                    }).on('swipeleft', function(e){
                        if (!$(e.target).hasClass('swipe-item')) {
                            _self.close();
                        }
                    });
                }
            } catch (err) {}

            this.wrap.on('touchmove', function(e){
                if (_self.state === 'opened') {
                    e.preventDefault();
                }
            });

        }
    }

    $.fn.gummMobileMenu = function gummMobileMenuFn(options, callback) {
        this.each(function () {
            var instance = $.data(this, 'gummMobileMenu');
            if (instance) {
                // update options of current instance
                // instance.update(options);
            } else {
                $.data(this, 'gummMobileMenu', new $.gummMobileMenu(options, callback, this));
            }

        });
        return this;
    }


    // DISCRETE LABELED FORM FN

    $.gummDiscreteLabeledForm = function(options, callback, element) {
        this.element = $(element);
        this.__construct(options, callback);
    }

    $.gummDiscreteLabeledForm.prototype = {
        __construct: function(options, callback) {
            this.inputs = this.element.find('input, textarea');
            this.bindListeners();
        },
        bindListeners: function() {
            this.inputs.on('focus', function(e){
                if ($(this).val() === $(this).data('default-label')) {
                    $(this).val('').removeClass('default-label-on');
                }
            });
            this.inputs.on('blur', function(e){
                if ($(this).val() === $(this).data('default-label')) {
                    $(this).addClass('default-label-on');
                } else if ($(this).val().length < 1) {
                    $(this).val($(this).data('default-label')).addClass('default-label-on');
                }
            });
        }
    }

    $.fn.gummDiscreteLabeledForm = function gummDiscreteLabeledFormFn(options, callback) {
        this.each(function () {
            var instance = $.data(this, 'gummDiscreteLabeledForm');
            if (instance) {
                // update options of current instance
                // instance.update(options);
            } else {
                $.data(this, 'gummDiscreteLabeledForm', new $.gummDiscreteLabeledForm(options, callback, this));
            }

        });
        return this;
    }

    // GUMM CONENT REVAEAL FN

    $.gummContentReveal = function gummMobileMenu(options, callback, element) {
        this.element = $(element);
        this.__construct(options, callback);
    }

    $.gummContentReveal.settings = {
        content: '.iphone-content',
        wrap: '.iphone-wrap',
        maxRelRight: 500
    }

    $.gummContentReveal.prototype = {
        lastPageX: 0,
        mouseRelX: 0,
        dir: null,
        contentEle: null,
        wrapEle: null,
        offsetLeft: null,
        screenWidth: null,
        currMatrix: [0, 0],
        __construct: function(options) {
            this.options = $.extend(true, {}, $.gummContentReveal.settings, options);
            if (this.element.data('max-rel-right') !== undefined) this.options.maxRelRight = this.element.data('max-rel-right');

            this.wrapEle = this.element.find(this.options.wrap);
            this.bindListeners();
        },
        reveal: function(mx) {
            this.lastPageX = mx;
            var relX = mx - this.offsetLeft;

            this.setDir(relX);
            var maxRelRight = this.options.maxRelRight;

            var bgPosition = null;
            var animate = false;
            var currGoToLeft = -relX;
            if (relX > 0 && relX <= maxRelRight) {
                relX = this.options.maxRelRight - relX;
                bgPosition = '-' + relX +'px 0px';
                // this.contentEle.css({
                //     backgroundPosition: '-' + relX +'px 0px'
                // });
            } else if (relX > maxRelRight && relX < (maxRelRight + 25)) {
                bgPosition = '0px 0px';
                currGoToLeft = 0;
                // this.contentEle.css({
                //     backgroundPosition: '0px 0px'
                // });
            } else if (relX < 0 && relX > -25) {
                bgPosition = '-' + this.options.maxRelRight + 'px 0px';
                currGoToLeft = this.options.maxRelRight;
                // this.contentEle.css({
                //     backgroundPosition: '-' + this.options.maxRelRight + 'px 0px'
                // });
            }
            if (bgPosition !== null) {
                if (animate) {
                    this.contentEle.stop().animate({
                        backgroundPosition: bgPosition
                    }, 250);
                } else {
                    this.contentEle.stop().css({
                        backgroundPosition: bgPosition
                    });
                }

                this.mouseRelX = relX;
            }

        },
        setDir: function(relX) {
            this.dir = (relX > this.mouseRelX) ? 'right' : 'left';
        },
        getDir: function() {
            return this.dir;
        },
        bindListeners: function() {
            var _self = this;
            this.element.on('mousemove', function(e){
                // if (!_self.element.is(':visible')) return;
                if (_self.contentEle === null)
                    _self.contentEle = _self.element.find(_self.options.content);
                if (_self.offsetLeft === null)
                    _self.offsetLeft = _self.contentEle.offset().left;
                if (_self.screenWidth === null)
                    _self.screenWidth = _self.wrapEle.width();
                _self.reveal(e.pageX);
            });
            this.element.on('mouseleave', function(e){
                // if (e.pageX < _self.lastPageX) {
                    _self.contentEle.animate({
                        backgroundPosition: '-' + _self.options.maxRelRight + 'px 0px'
                    }, 350);
                // } else {
                //     _self.contentEle.css({
                //         backgroundPosition: '0px 0px'
                //     });
                // }
            });
        }
    }

    $.fn.gummContentReveal = function gummContentRevealFn(options, callback) {
        this.each(function () {
            var instance = $.data(this, 'gummContentReveal');
            if (instance) {
                // update options of current instance
                // instance.update(options);
            } else {
                $.data(this, 'gummContentReveal', new $.gummContentReveal(options, callback, this));
            }

        });
        return this;
    }

    // ============== //
    // GAUGE CHART FN //
    // ============== //

    $.gummGaugeChart = function(options, callback, element) {
        this.element = $(element);
        this.__construct(options, callback);
    }

    $.gummGaugeChart.prototype = {
        ctx: null,
        degrees: 0,
        drawnDegrees: 0,
        diff: 0,
        lineWidth: 10,
        animationInterval: null,
        step:1,
        refreshRate:10,
        supportGummScrollr: true,
        __construct: function(options, callback) {
            this.width      = this.element.data('width');
            this.height     = this.element.data('height');
            this.lineWidth  = this.element.data('line-width');
            this.percent    = parseInt(this.element.data('percent'));
            this.color      = this.element.data('color');
            this.bgColor    = this.element.data('background-color');
            this.textSource = this.element.data('text-source');
            this.textBox    = $(this.element.data('text-box'));
            this.fontSize   = this.element.data('font-size');
            this.speed      = this.element.data('animation-speed');

            if (this.speed === undefined) {
                this.speed = 300;
            } else {
                this.speed = parseInt(this.speed);
            }

            this.degrees    = Math.floor(360*this.percent/100);
            this.radius     = Math.min(this.width, this.height) / 2 - (this.lineWidth / 2);
            this.step       = this.degrees/(this.speed/this.refreshRate)

            this.ctx        = this.element.get(0).getContext("2d");

            this.renderContentBox();
            var _self = this;
            if (this.supportGummScrollr) {
                this.element.bind('gummScrollred', function(){
                    _self.start();
                });
            } else {
                this.start();
            }
        },
        renderContentBox: function() {
            if (this.textBox.length > 0) {
                this.textBox.css({
                    position: 'absolute',
                    top: '50%',
                    left: '50%',
                    fontSize: this.fontSize,
                    lineHeight: this.fontSize + 'px',
                    color: this.color
                });
                if (this.textSource === 'symbol') {
                    this.textBox.children('.number').text(Math.ceil(this.drawnDegrees/360*100));
                }
                var _self = this;
                setTimeout(function(){
                    var width = _self.textBox.width();
                    var height = _self.textBox.height();

                    _self.textBox.css({
                        marginLeft: -(Math.floor(width/2)),
                        marginTop: -(Math.floor(height/2))
                    });
                }, 1);

            }
        },


        start: function() {
            var _self = this;
            if (this.speed > 0) {
                this.animationInterval = setInterval(function(){
                    _self.animate();
                }, this.refreshRate);
            } else {
                this.draw(this.degrees);
            }

        },
        animate: function() {
            if (this.drawnDegrees === this.degrees) {
                clearInterval(this.animationInterval);
            } else {
                this.drawnDegrees += this.step;
                if (this.drawnDegrees > this.degrees) {
                    this.drawnDegrees = this.degrees;
                }
                this.draw(this.drawnDegrees);
            }
        },
        draw: function(degrees) {
            // clear the scene
            this.ctx.clearRect(0, 0, this.width, this.height);

            // draw the bg stroke
            this.ctx.beginPath();
            this.ctx.strokeStyle    = this.bgColor;
            this.ctx.lineWidth      = this.lineWidth;
            this.ctx.arc(this.width/2, this.height/2, this.radius, 0, Math.PI*2, false);
            this.ctx.stroke();

            // draw the gauge stroke
    		var radians = degrees * Math.PI / 180;
            this.ctx.beginPath();
            this.ctx.strokeStyle    = this.color;
            this.ctx.lineWidth      = this.lineWidth;
            this.ctx.arc(this.width/2, this.height/2, this.radius, 0 - 90*Math.PI/180, radians - 90*Math.PI/180, false);
            this.ctx.stroke();

            this.renderContentBox();
        }
    }

    $.fn.gummGaugeChart = function gummGaugeChartFn(options, callback) {
        this.each(function () {
            var instance = $.data(this, 'gummGaugeChart');
            if (instance) {
                // update options of current instance
                // instance.update(options);
            } else {
                $.data(this, 'gummGaugeChart', new $.gummGaugeChart(options, callback, this));
            }

        });
        return this;
    }

    /* GummTermsScroller */

    $.gummTermsScroller = function gummTermsScroller(options, callback, element) {
        this.element = $(element);
        this.__construct();
    }

    $.gummTermsScroller.settings = {
        nav: '.terms-alphabet',
        navItems: 'li > a',
        content: '.offers-table',
        contentItems: 'tr.new-letter'
    }

    $.gummTermsScroller.prototype = {
        navOriginTop: 0,
        topDeviation: 10,
        navHeight: 0,
        navWidth: 0,
        navClone: null,
        navState: 'attached',
        activeTerm: null,
        activeTermItem: null,
        contentItemsOffsets: [],
        animating: false,
        __construct: function(options, callback) {
            this.options = $.extend(true, {}, $.gummTermsScroller.settings, options);
            this.navElement = this.element.find(this.options.nav);
            this.navItems = this.navElement.find(this.options.navItems);
            this.content = this.element.find(this.options.content);
            this.contentItems = this.content.find(this.options.contentItems);

            var _self = this;
            this.contentItems.each(function(i, ele){
                _self.contentItemsOffsets.push({
                    term: $(ele).data('scrolltotarget'),
                    top: $(ele).offset().top,
                    bottom: $(ele).height() + $(ele).offset().top
                });
            });

            if ($('#wpadminbar').size() > 0) {
                this.topDeviation += $('#wpadminbar').outerHeight();
            }
            this.navOriginTop = this.getNavOffsetTop();
            this.navHeight = this.navElement.outerHeight();
            this.navWidth = this.navElement.width();
            this.navElement.css({position: 'relative'});
            this.contentItems = this.element.find(this.options.contentItems);

            this.navClone = $('<div></div>');
            this.navClone.height(this.navHeight + parseInt(this.navElement.css('marginTop')) + parseInt(this.navElement.css('marginBottom'))).css({display: 'none'});
            this.navElement.before(this.navClone);

            this.lastWindowWidth = $('body').width();

            this.bindListeners();
        },
        getNavOffsetTop: function() {
            return this.navElement.offset().top - this.topDeviation;
        },
        getNavOriginTop: function() {
            return this.element.offset().top - this.topDeviation;
        },
        setActiveTerm: function(term) {
            if (term === null) {
                this.navItems.parent().removeClass('selected');
                this.activeTermItem = null;
                this.activeTerm = null;
            } else if (term !== undefined) {
                var theItem = this.navItems.filter('[data-scrollto=' + term + ']');
                if ($(this.activeTermItem).size() > 0) {
                    this.activeTermItem.parent().removeClass('selected');
                }
                theItem.parent().addClass('selected');
                this.activeTermItem = theItem;
                this.activeTerm = term;
            }
        },
        getCurrentScrolledToTerm: function(scrollTop) {
            scrollTop += this.topDeviation + this.navElement.outerHeight() + 20;
            var term = null;
            $.each(this.contentItemsOffsets, function(i, ele){
                if (scrollTop > (ele.top + 20) && scrollTop < (ele.bottom - 20)) {
                    term = ele.term;
                    return;
                }
            });

            return term;
        },
        bindListeners: function() {
            var _self = this;
            $(window).on('scroll', function(e){
                var windowTop = $(this).scrollTop();
                var originTop = _self.getNavOriginTop();
                // console.log(originTop);
                if (windowTop > _self.getNavOriginTop() && _self.navState == 'attached') {
                    // $(window).trigger('resize');
                    _self.navState = 'detached';
                    _self.navElement.addClass('detached').css({
                        position: 'fixed',
                        top: _self.topDeviation,
                        left: _self.content.offset().left
                    }).innerWidth(_self.content.width());
                    _self.navClone.show();
                } else if (windowTop <= _self.getNavOriginTop() && _self.navState == 'detached') {
                    // _self.navWidth += parseInt(_self.navElement.css('paddingLeft')) - parseInt(_self.navElement.css('paddingRight'));
                    _self.navState = 'attached';
                    _self.navElement.removeClass('detached').css({
                        position: 'relative',
                        top: 'auto',
                        left: 'auto',
                        width: '',
                    });
                    // .innerWidth(_self.navWidth)
                    _self.navClone.hide();

                    _self.setActiveTerm(null);
                }

                if (_self.navState == 'detached' && _self.animating === false) {
                    var scrollToTerm = _self.getCurrentScrolledToTerm(windowTop);
                    if (scrollToTerm !== null && scrollToTerm != _self.activeTerm) {
                        _self.setActiveTerm(scrollToTerm);
                    }
                }

                // console.log(e);
                // if (windowTop > _self.navOriginTop) {
                    // _self.navElement.css({top: windowTop - _self.navOriginTop});
                    // if (!_self.navElement.hasClass('detached')) _self.navElement.addClass('detached');
                // } else {
                    // _self.navElement.css({top: 'auto'});
                    // _self.navElement.removeClass('detached');
                // }
            });

            $(window).on('resize', function(e){
                var width = _self.navElement.parent().width();
                _self.navElement.innerWidth(width);
                _self.navWidth = width;
            });

            $(document).on('gummLayoutChanged', function(e){
                if (_self.navState == 'detached') {
                    _self.navElement.css({
                        left: _self.content.offset().left
                    });
                }
            });

            this.navItems.on('click', function(e){
                e.preventDefault();
                if ($(this).parent().hasClass('no-terms') || _self.animating) return false;

                _self.animating = true;

                var target = $(this).data('scrollto');
                _self.setActiveTerm(target);

                $('html, body').animate({
                    scrollTop: _self.contentItems.filter('[data-scrolltotarget=' + target + ']').offset().top - 100
                }, 500, function() {
                    _self.animating = false;
                });
            });
        }
    }

    $.fn.gummTermsScroller = function gummTermsScrollerFn(options, callback) {
        this.each(function () {
            var instance = $.data(this, 'gummTermsScroller');
            if (instance) {
                // update options of current instance
                // instance.update(options);
            } else {
                $.data(this, 'gummTermsScroller', new $.gummTermsScroller(options, callback, this));
            }

        });
        return this;
    }

})(jQuery);

/**
 * @author Alexander Farkas
 * v. 1.22
 */
(function($) {
	if(!document.defaultView || !document.defaultView.getComputedStyle){ // IE6-IE8
		var oldCurCSS = $.css;
		$.css = function(elem, name, force){
			if(name === 'background-position'){
				name = 'backgroundPosition';
			}
			if(name !== 'backgroundPosition' || !elem.currentStyle || elem.currentStyle[ name ]){
				return oldCurCSS.apply(this, arguments);
			}
			var style = elem.style;
			if ( !force && style && style[ name ] ){
				return style[ name ];
			}
			return oldCurCSS(elem, 'backgroundPositionX', force) +' '+ oldCurCSS(elem, 'backgroundPositionY', force);
		};
	}

	var oldAnim = $.fn.animate;
	$.fn.animate = function(prop){
		if('background-position' in prop){
			prop.backgroundPosition = prop['background-position'];
			delete prop['background-position'];
		}
		if('backgroundPosition' in prop){
			prop.backgroundPosition = '('+ prop.backgroundPosition;
		}
		return oldAnim.apply(this, arguments);
	};

	function toArray(strg){
		strg = strg.replace(/left|top/g,'0px');
		strg = strg.replace(/right|bottom/g,'100%');
		strg = strg.replace(/([0-9\.]+)(\s|\)|$)/g,"$1px$2");
		var res = strg.match(/(-?[0-9\.]+)(px|\%|em|pt)\s(-?[0-9\.]+)(px|\%|em|pt)/);
		return [parseFloat(res[1],10),res[2],parseFloat(res[3],10),res[4]];
	}

	$.fx.step. backgroundPosition = function(fx) {
		if (!fx.bgPosReady) {
			var start = $.css(fx.elem,'backgroundPosition');
			if(!start){//FF2 no inline-style fallback
				start = '0px 0px';
			}

			start = toArray(start);
			fx.start = [start[0],start[2]];
			var end = toArray(fx.end);
			fx.end = [end[0],end[2]];

			fx.unit = [end[1],end[3]];
			fx.bgPosReady = true;
		}
		//return;
		var nowPosX = [];
		nowPosX[0] = ((fx.end[0] - fx.start[0]) * fx.pos) + fx.start[0] + fx.unit[0];
		nowPosX[1] = ((fx.end[1] - fx.start[1]) * fx.pos) + fx.start[1] + fx.unit[1];
		fx.elem.style.backgroundPosition = nowPosX[0]+' '+nowPosX[1];

	};
})(jQuery);
