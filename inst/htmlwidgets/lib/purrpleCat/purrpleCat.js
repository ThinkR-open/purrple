$( function(){

  var mp3 = $("#purrpleCat-sound-attachment").attr("href") ;
  var img = $("#purrpleCat-image-attachment").attr("href") ;
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

  $("#purrple_cat_logo").html( $img ) ;
  $img.animate( { opacity: 1}, 5000 ) ;

}) ;
