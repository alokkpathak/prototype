$(document).ready(function() {
$("#inTouch").on('click', function(){

        app.analytics.pushEvent('Click','homepage get in touch', 'healthcare professional', 'visit website');
});

$("#macbutton").on('click', function(){
    	var title = $(document).attr('title');
		app.analytics.pushEvent('download',title ,'software', 'mac download');
});

$("#pcbutton").on('click', function(){
		var title = $(document).attr('title');
		app.analytics.pushEvent('download',title ,'software', 'pc download');
});

$("#getSoftware").on('click', function(){
		var title = $(document).attr('title');
		app.analytics.pushEvent('download',title ,'software', 'get the software');
});

$("#valueCountry").on('click', function(){
		var countryValue =  $(this).attr("alt");
		app.analytics.pushEvent('CountrySelection','change country' ,'selection', countryValue);
});

$("#prodRelOne").on('click', function(){
    var product=$("#prodOneRel").val();
	app.analytics.pushEvent('Click','Buy them separately' ,product, 'Find out more');
});
$("#prodRelTwo").on('click', function(){
    var product=$("#prodTwoRel").val();
	app.analytics.pushEvent('Click','Buy them separately' ,product, 'Find out more');
});
$("#buySupport").on('click', function(){
    var pageTitle = $(document).attr('title');
    var componetName = $(this).find('span').html();
	app.analytics.pushEvent('Click', pageTitle , componetName , 'buy online');

});
$("#buySupport2").on('click', function(){
    var pageTitle = $(document).attr('title');
    var componetName = $(this).find('span').html();
	app.analytics.pushEvent('Click', pageTitle , componetName , 'support');

});
$("#buySupport3").on('click', function(){
    var pageTitle = $(document).attr('title');
    var componetName = $(this).find('span').html();
	app.analytics.pushEvent('Click', pageTitle , componetName , 'living with diabetes');

});
$("#linkValueHit1 li").click(function() {
    	var menuLabel = '';
		var pageTitle = $('title').html();
        var subMenu = $(this).html();
    	app.analytics.pushEvent('Click', pageTitle , menuLabel , subMenu);

});
$("#linkValueHit2 li").click(function() {
		var menuLabel = '';
		var pageTitle = $('title').html();
        var subMenu = $(this).html();
    	app.analytics.pushEvent('Click', pageTitle ,menuLabel , subMenu);

});
$("#linkValueHit3 li").click(function() {
		var menuLabel = '';
        var pageTitle = $('title').html();
        var subMenu = $(this).html();
    	app.analytics.pushEvent('Click', pageTitle , menuLabel , subMenu);

});
$('.logAnalyticsId,.inTouchFaq').click(function(){
app.analytics.pushEvent('Click', 'homepage get in touch' , 'questions' , 'faq section');
});
$('.seebtn,#decouvrir_1,#decouvrir_2,#decouvrir_3,#decouvrir_4,#decouvrir_5,#decouvrir_6,#support_1,#support_2,#support_3,#support_4,#discover_1,#discover_2,#discover_3,#discover_4,#discover_5,#discover_6,#help_1,#help_2,#help_3,#help_4,#products_1,#products_2,#packs_1,#packs_2,#splOffer_1,#scoprire_1,#scoprire_2,#scoprire_3,#scoprire_4,#scoprire_5,#scoprire_6,#aiuto_1,#aiuto_2,#aiuto_3,#aiuto_4').click(function(){
	var pageTitle = $('title').html();
 	var menuTitle = $('.active-menu').html();
    var subMenu;
    if($(this).html().indexOf('img') >= 0 ){
	 subMenu = $(this).parent().find(".prod-sub-text").html();
    }else{
		subMenu = $(this).html();
    }
    app.analytics.pushEvent('Click', pageTitle , menuTitle , subMenu);
});


$('#fbShare,#fbShare1').click(function(){
    var pageTitle = $('title').html();
    app.analytics.pushEvent('Click', 'share-' + pageTitle , 'page-' + pageTitle , 'Facebook');
});
$('#twitShare,#twitShare1').click(function(){
     var pageTitle = $('title').html();
     app.analytics.pushEvent('Click', 'share-' + pageTitle , 'page-' + pageTitle , 'Twitter');
});
$('#pinchShare,#pinchShare1').click(function(){
var pageTitle = $('title').html();
    app.analytics.pushEvent('Click', 'share-' + pageTitle , 'page-' + pageTitle , 'Pinterest');
});
$('#emailShare,#emailShare1').click(function(){
var pageTitle = $('title').html();
    app.analytics.pushEvent('Click', 'share-' + pageTitle , 'page-' + pageTitle , 'Email');
});


$('#fbShareVideo,#fbShareVideo1').click(function(){
    var pageTitle = $('title').html();
    app.analytics.pushEvent('Click', 'share-' + pageTitle , 'video-' + pageTitle , 'Facebook');
});
$('#twitShareVideo,#twitShareVideo1').click(function(){
    var pageTitle = $('title').html();
    app.analytics.pushEvent('Click', 'share-' + pageTitle , 'video-' + pageTitle , 'Twitter');
});
$('#pinchShareVideo,#pinchShareVideo1').click(function(){
    var pageTitle = $('title').html();
    app.analytics.pushEvent('Click', 'share-' + pageTitle , 'video-' + pageTitle , 'Pinterest');
});
$('#emailShareVideo,#emailShareVideo1').click(function(){
    var pageTitle = $('title').html();
    app.analytics.pushEvent('Click', 'share-' + pageTitle , 'video-' + pageTitle , 'Email');
});


$('#checkPrivacyPolicyId').click(function(){
    var pageTitle = $('title').html();
    var linkValue = $('#checkPrivacyPolicyId').html();
   app.analytics.pushEvent('Click', pageTitle ,linkValue , '');
});

$('#privacyPolicyId').click(function(){
    var pageTitle = $('title').html();
    var linkValue = $('#privacyPolicyId').html();
   app.analytics.pushEvent('Click', pageTitle ,linkValue , '');
});

$('#discoverAnalytics').click(function(){
app.analytics.pushEvent('Click', 'Homepage' , 'top banner' , 'Discover it');
});
$('#buyAnalytics').click(function(){
app.analytics.pushEvent('Click', 'Homepage' , 'top banner' , 'Buy Now');
});
$('#footer_row1_1,#footer_row1_2,#footer_row1_3,#footer_row1_4,#footer_row1_5,#footer_row1_6,#footer_row1_7,#footer_row1_8,#footer_row2_1,#footer_row2_2,#sitemap_1,#sitemap_2,#sitemap_3,#sitemap_4,#sitemap_5').click(function(){
    var pageTitle = $('title').html();
    var menuTitle;
    if($(this).html().indexOf('<b>') >=0 ){
        menuTitle = $(this).find('b').html();
    }else if ($(this).html().indexOf('<strong>') >=0 ){
		menuTitle = $(this).find('strong').html();
     } else{
		menuTitle = $(this).html();
    }
	app.analytics.pushEvent('Click', pageTitle , 'footer' , menuTitle );
});
$('.discover1,.padding-disc,.readmore').click(function(){
    var pageTitle = $('title').html();
	app.analytics.pushEvent('Click', pageTitle , 'mosaic' , pageTitle);
});
$('#googlePlayGA,.downloadAndroid').click(function(){
    var pageTitle = $('title').html();
	app.analytics.pushEvent('Click', pageTitle , 'Google Play' , 'download');
});
});
