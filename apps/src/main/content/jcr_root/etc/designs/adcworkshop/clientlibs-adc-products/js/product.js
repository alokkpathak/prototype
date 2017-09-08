(function() {
	/*Default constructor*/
	function Product(){
		this.init();
	};

	Product.prototype.init = function(){
		 var isMobile =/Android|webOS|iPhone|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
		var self= this;
		if(!($(window).width() > 1200)){
			$('.product-thumbnail').on('click',function(){
				self.enlarge();
			});
		}
		else{
			/*To initialize magnifier*/
			$host = $('[mag-thumb="outer"]');
				$host.mag({
				  mode: 'outer',
				  smooth: true
			});
		}
        $(".prodSpinner").TouchSpin({
            verticalbuttons: true,
            min:1,
            stepinterval:1
        });
		$('div[mag-thumb="outer"]').on('mouseover',function(){
			$('.img-zoom-wrapper').addClass('zoom-box-shadow');

		});
		$('div[mag-thumb="outer"]').on( "mouseleave", function(){
			$('.img-zoom-wrapper').removeClass('zoom-box-shadow');
		});

		/*binding event for image gallery*/
		$(".lstProductImage").find('li').find('.img-gallery').on("click", function(){
			self.view($(this));
		});

		$('.prodMenu').find('a').click(function(){
			closeButtonClick = false;
            self.closeDetail();
    	});

  		$('.close-product').click(function(){
			closeButtonClick = true;
            self.closeDetail();
  		});

  		/*Removing border to active li on collapsing of menu tab content*/
  		$('#prodMenuContent').find('.collapse').on('hidden.bs.collapse', function () {
  			$('.prodMenu').find('a[href="#'+$(this).attr('id')+'"]').closest('li').css('border-bottom','none');

		});
		/*Adding border to active li on expanding of product menu tab*/
  		$('#prodMenuContent').find('.collapse').on('show.bs.collapse', function () {
  			$('.prodMenu').find('a[href="#'+$(this).attr('id')+'"]').closest('li').css('border-bottom','3px solid #626262');

		});

  		/*Next and Previous view of Image gallery - on mobile */
		$(".prod-arr-right-mob").find('img').on("click", function(){
			self.next($(this));
		});
		$(".prod-arr-left-mob").find('img').on("click", function(){
			self.previous($(this));
		});

		$('.prod-arr-left-mob').hide();

		/*Display first image as product on load*/
		var defaultImage = $('.lstProductImage').find('li').find('.img-gallery')[0];
		self.view(defaultImage);

		$('.drop_down_content').find('.collapse').on('shown.bs.collapse', function () {
			$('.sp-product-yellow').css({'padding-top':'100px'});

		});
	}

	/*Function to load product image on click of Image Gallery*/
	Product.prototype.view = function(image){
		$('.product-thumbnail').find('img').attr('src',$(image).attr('src'));
		$('.img-zoom-wrapper').find('img').attr('src',$(image).attr('src'));
	}

	Product.prototype.closeDetail = function(){
		var currentlyShown= $('#prodMenuContent').find('.collapse.in');

    	setTimeout(function(){
            if($('#prodMenuContent').find('.in').length > 0){
                //For mobile
	  			if( /Android|webOS|iPhone|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
	  				$('.sp-product-yellow').css({'padding-top':'450px'});
                }else if(/ipad/i.test(navigator.userAgent)){
					$('.sp-product-yellow').css({'padding-top':'350px'});
                }else{
                    $('.sp-product-yellow').css({'padding-top':'250px'});
                }
            }
	  		else
	  		{
	  			//For mobile
	  			if( /Android|webOS|iPhone|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
	  				$('.sp-product-yellow').css({'padding-top':'450px'});
				}

				else if(/ipad/i.test(navigator.userAgent)){
					//For ipad portrait
					if(window.innerHeight > window.innerWidth)
						$('.sp-product-yellow').css({'padding-top':'350px'});
					else
						$('.sp-product-yellow').css({'padding-top':'350px'});
				}
    			else
	  				$('.sp-product-yellow').css({'padding-top':'250px'});
	  		}
            if(closeButtonClick){
                var hasNextSection = $('.prodMenu').find("[aria-expanded='true']").parent().next();
                if(hasNextSection.length > 0){
					$(hasNextSection).children().focus();
                }else{
                    $('.prodMenu li:last').children().focus();
                }
                closeButtonClick = false;
            }
	  		$(currentlyShown).collapse('hide');
    	},200);
	}

	/*Show Next images - for Image Gallery on mobile*/
	Product.prototype.next = function(){
		$(".lstProductImage").find('li:lt(2)').hide();
		$(".lstProductImage").find('li:gt(2)').removeClass('hidden-xs');
		$('.prod-arr-right-mob').hide();
		$('.prod-arr-left-mob').show();
	}
	/*show Previous images - for Image Gallery on mobile*/
	Product.prototype.previous = function(){
		$(".lstProductImage").find('li:lt(2)').show();
		$(".lstProductImage").find('li:gt(3)').addClass('hidden-xs');
		$('.prod-arr-right-mob').show();
		$('.prod-arr-left-mob').hide();
	}

	Product.prototype.enlarge = function(){
		var source= $('.product-thumbnail').find('img');
		$('#enlargemodal').find('img').attr('src',$(source).attr('src'));
		 $('#enlargemodal').modal('show');
	}
    app.product = new Product();
})();