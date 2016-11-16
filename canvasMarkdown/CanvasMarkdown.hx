package canvasMarkdown;
import canvasMarkdown.SvgRoot;
import canvasMarkdown.SvgForeign;
import canvasMarkdown.CanvasWrapper;
import js.Browser;
import js.html.Node;
import js.html.svg.SVGElement;
import js.html.svg.GraphicsElement;
import js.html.Image;
import js.html.Blob;
import js.html.URL;
import js.html.XMLSerializer;
import js.html.Uint8ClampedArray;
import js.html.CanvasRenderingContext2D;
class CanvasMarkdown {
    var w: Int;
    var h: Int;
    var md: String;
    var url: String;
    var img = new Image();
    var doc = Browser.window.document;
    var body = Browser.window.document.body;
    var ctx: CanvasRenderingContext2D;
    var canvas: CanvasWrapper;
    public var svgRoot: SvgRoot;
    var loaded: Void->Void;
    public var hasLoaded: Bool = false;
    public function new( x_: Int, y_: Int, w_: Int, h_: Int ){
        w = w_;
        h = h_;
        hasLoaded = false;
        svgRoot = new SvgRoot();
        svgRoot.width = w;
        svgRoot.height = h;
        var svg: SVGElement = svgRoot;
        body.removeChild( svg );
        canvas = new CanvasWrapper();
        canvas.width = w;
        canvas.height = h;
        canvas.x = x_;
        canvas.y = y_;
        ctx = canvas.getContext2d();
    }
    public function add( md_: String, loaded_: Void->Void ){
        md = md_;
        loaded = loaded_;
        var foreign = createForeign( md );
        var svg: SVGElement = svgRoot;
        var data = (new XMLSerializer()).serializeToString( svg );
        var blob = new Blob( [ data ], {type: 'image/svg+xml;charset=utf-8'});
        url = URL.createObjectURL( blob );
        img.onload = svgAsImageLoaded;
        img.src = url;
    }
    public function transformFunction( f: Uint8ClampedArray->Int->Int->Void ){
        var imageData = ctx.getImageData( 0, 0, w, h );
        var dataIn = new Uint8ClampedArray( imageData.data.buffer );
        f( dataIn, w, h );
        ctx.putImageData( imageData, 0, 0 );
        Browser.document.body.appendChild( cast( canvas, Node ) );
    }
    function svgAsImageLoaded(){
        ctx.drawImage( img, 0, 0 );
        URL.revokeObjectURL( url );
        Browser.document.body.appendChild( cast( canvas, Node ) );
        hasLoaded = true;
        loaded();
     }
    function createForeign( content_: String ): SvgForeign {
        var svgForeign = new SvgForeign();
        svgForeign.x = 0;
        svgForeign.y = 0;
        svgForeign.markDown( content_ );
        svgRoot.appendChild( svgForeign );
        return svgForeign;
    }
}
