HTMLWidgets.widget({

  name: 'JcropImage',

  type: 'output',

  factory: function(el, width, height) {

    var gadget = null ;
    var id = el.id ;
    var src = null ;
    var $img = null ;
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
        "width": width,
        "height": height
      }) ;

    } ;

    var getImage = function() {
      return $("#" + target + " :first") ;
    } ;

    var onChange = function(c){
      Shiny.onInputChange( id + "_change", c ) ;
    } ;

    var onSelect = function(c){
      Shiny.onInputChange( id + "_select", c ) ;
    } ;

    var onRelease = function(){
      Shiny.onInputChange( id + "_select", null ) ;
      Shiny.onInputChange( id + "_change", null ) ;
    } ;

    return {
      renderValue: function(x) {
        if( x === null) return ;

        src = x.data ;

        if( $img === null ){
          $(el).append( '<img />') ;
          $img = $( "#" + id + " img") ;
          if( x.data.alt ) $img.attr( "alt" , x.data.alt ) ;

          $img.load( function(){
            x_width = $img.width() ;
            x_height = $img.height() ;

            reset( $(el).width(), $(el).height() ) ;

            $img.Jcrop({
              aspectRatio: x.aspect_ratio,
              bgColor: x.bg,
              bgOpacity: x.opacity,
              onChange: onChange,
              onSelect: onSelect,
              onRelease: onRelease
            }, function(){
              gadget = this ;
              el.gadget = this ;
            }) ;

          }) ;

          $img.attr("src", src) ;

        } else {
            gadget.setImage( src ) ;
            Shiny.onInputChange( id + "_select", null ) ;
            Shiny.onInputChange( id + "_change", null ) ;
        }

      },

      resize: function(width, height) {}

    };
  }
});
