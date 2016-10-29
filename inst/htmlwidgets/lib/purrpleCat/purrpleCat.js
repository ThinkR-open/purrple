$( function(){

  var mp3 = $("#purrple-sound-attachment").attr("href") ;
  var img = $("#purrple-image-attachment").attr("href") ;
  purr_sound = new Audio(mp3) ;

  $img = $("<img>") ;
  $img.attr("src", img );
  $img.css({
    position: "absolute" ,
    right: "10px",
    bottom: "10px",
    height: "50px",
    opacity: 0
  }) ;

  $img.hover( function(){
    purr_sound.play() ;
  }) ;

  $("body").append( $img ) ;
  $img.animate( { opacity: 1}, 5000 ) ;

}) ;
