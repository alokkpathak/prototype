var tag = document.createElement('script');
tag.src = "https://www.youtube.com/iframe_api";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

var player;
function onYouTubeIframeAPIReady() {
    player = new YT.Player('playerembd', {
        events: {
            'onReady': onPlayerReady,
			'onStateChange': onPlayerStateChange
        }
    });
}


function onPlayerReady(event) {
    player.playVideo();
    event.target.mute();
}
function onPlayerStateChange(playerStatus){
    var pageTitle = $(document).attr('title');
    var videoTitle = player.getVideoData().title;
    app.analytics.pushEvent('VideoPlay', pageTitle , 'video play' , videoTitle);
}



