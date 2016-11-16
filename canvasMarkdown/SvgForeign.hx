package canvasMarkdown;
import js.Browser;
import js.html.svg.SVGElement;
import js.html.svg.ForeignObjectElement;
import js.html.DivElement;
import js.html.Node;
using Markdown;
@:forward( appendChild, removeChild )
abstract SvgForeign( ForeignObjectElement ) from ForeignObjectElement to ForeignObjectElement {
    inline public static var svgNameSpace: String = "http://www.w3.org/2000/svg" ;
    static inline var _FONT = '</FONT>';
    static inline var FONT_ = '<FONT FACE="Trebuchet MS, Helvetica, sans-serif">';
    public inline function new( ?e: ForeignObjectElement ){
        if( e == null ){
            this = create();
        } else {
            this = e;
        }
    }
    inline static public function create(): ForeignObjectElement {
        var svgForeign: ForeignObjectElement = cast Browser.document.createElementNS( svgNameSpace, 'foreignObject' );
        return svgForeign;
    }
    public var x( get, set ): Int;
    inline public function set_x( x_: Int ):Int {
        this.setAttribute( "x", Std.string( x_ ) );
        return( x_ );
    }
    inline public function get_x(): Int {
        return Std.parseInt( this.getAttribute( "x" ) );
    }
    public var y( get, set ): Int;
    inline public function set_y( y_: Int ):Int {
        this.setAttribute( "y", Std.string( y_ ) );
        return( y_ );
    }
    inline public function get_y(): Int {
        return Std.parseInt( this.getAttribute( "y" ) );
    }
    public var width( get, set ): Int;
    inline public function set_width( width_: Int ):Int {
        this.setAttribute( "width", Std.string( width_ ) );
        return( width_ );
    }
    inline public function get_width(): Int {
        return Std.parseInt( this.getAttribute( "width" ) );
    }
    public var height( get, set ): Int;
    inline public function set_height( height_: Int ):Int {
        this.setAttribute( "height", Std.string( height_ ) );
        return( height_ );
    }
    inline public function get_height(): Int {
        return Std.parseInt( this.getAttribute( "height" ) );
    }
    public function markDown( md: String ) {
        var doc = js.Browser.window.document;
        var div = doc.createDivElement();
        div.innerHTML = FONT_ + md.markdownToHtml() + _FONT;
        doc.body.appendChild( div );        
        width = Std.int( div.offsetWidth );
        height = Std.int( div.offsetHeight );
        doc.body.removeChild( div );
        this.appendChild( cast( div, Node ) );
    }
}
