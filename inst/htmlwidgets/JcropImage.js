HTMLWidgets.widget({

  name: 'JcropImage',

  type: 'output',

  factory: function(el, width, height) {

    var gadget = null ;
    var id = el.id ;
    var src = null ;
    var img = null ;

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
      Shiny.onInputChange( id + "_release" ) ;
    } ;

    return {
      renderValue: function(x) {
          var new_src = x.data.src ;
          src = new_src ;

          if( img === null ){
            $(el).append( '<img />') ;
            img = $( "#" + id + " img") ;
            img.attr("src", src) ;
            if( x.data.width ) img.width( x.data.width ) ;
            if( x.data.height ) img.width( x.data.height ) ;
            if( x.data.alt ) img.attr( "alt" , x.data.alt ) ;

            img.Jcrop({
              aspectRatio: x.aspect_ratio,
              bgColor: x.bg,
              bgOpacity: x.opacity,
              onChange: onChange,
              onSelect: onSelect,
              onRelease: onRelease
            }, function(){
              gadget = this ;
            }) ;
          } else {
              gadget.setImage( src ) ;
          }

      },

      resize: function(width, height) {
      }

    };
  }
});
