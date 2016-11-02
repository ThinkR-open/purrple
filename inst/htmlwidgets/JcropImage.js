HTMLWidgets.widget({

  name: 'JcropImage',

  type: 'output',

  factory: function(el, width, height) {

    var id = el.id ;
    var src = null ;
    var $img = null ;
    var gadget = null ;
    var previous_x = null ;
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

    var render = function(x, $el, width, height) {
        if( x === null) return ;

        if( gadget ) gadget.destroy() ;

        src = x.data ;

        $el.html( '<img />') ;
        $img = $( "#" + id + " img") ;
        if( x.data.alt ) $img.attr( "alt" , x.data.alt ) ;

        $img.load( function(){
          x_width = $img.width() ;
          x_height = $img.height() ;

          reset( width, height ) ;

          $img.Jcrop({
            aspectRatio: x.aspect_ratio,
            bgColor: x.bg,
            bgOpacity: x.opacity,
            onChange: onChange,
            onSelect: onSelect,
            onRelease: onRelease
          }, function(){
            gadget = this ;
          }) ;

        }) ;

        $img.attr("src", src) ;

      } ;

    return {
      renderValue: function(x){
        previous_x = x ;
        render(x, $(el), $(el).width(), $(el).height() ) ;
      },
      resize: function(width, height) {
        render(previous_x, $(el), width, height ) ;
      }

    };
  }
});
