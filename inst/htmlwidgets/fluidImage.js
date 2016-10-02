HTMLWidgets.widget({

  name: 'fluidImage',

  type: 'output',

  factory: function(el, width, height) {
    var id = null  ;
    var src ;
    var $img ;
    var x_width, x_height ;

    var reset = function( w, h ){
      var ratio = x_width / x_height ;
      var width = x_width ;
      var height = x_height ;

      if( width > w){
        width = w ;
        height = width / ratio ;
      }
      if( height > h ){
        height = h ;
        width  = height * ratio ;
      }

      $img.css({
        width: width,
        height: height
      }) ;

    } ;

    return {

      renderValue: function(x) {
        if( id === null){
          id = el.id;
          $(el).append( "<img/>") ;
          $img = $("#" + id + " img") ;
          $img.load( function(){
            x_width = $img.width() ;
            x_height = $img.height() ;
            reset( $(el).width(), $(el).height() ) ;
          }) ;
        }
        src = x.data ;

        $img.attr("src", src) ;
      },

      resize: function(width, height) {
        reset(width, height) ;
      }

    };
  }
});
