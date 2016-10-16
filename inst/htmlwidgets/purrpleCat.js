HTMLWidgets.widget({
  name: 'purrpleCat',
  type: 'output',

  factory: function(el, width, height) {

    var purr_sound  ;

    return {

      renderValue: function(x) {
        purr_sound = new Audio(x.mp3) ;

        $img = $("<img>") ;
        $img.attr("src", x.img );
        $img.css({
          position: "absolute" ,
          right: "10px",
          bottom: "10px",
          height: "50px"
        }) ;

        $img.hover( function(){
          purr_sound.play() ;
        }) ;

        $(el).html( $img ) ;

      },

      resize: function(width, height) {}

    };
  }
});
