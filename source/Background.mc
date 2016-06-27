using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

class Background extends Ui.Drawable {
	
	var background;
	var bgcolor;
	
    function initialize(params) {
    	// Read in parameters
    	if (params == null) { 
    		params = {}; 
    		color = Gfx.COLOR_BLACK;
    	} else {
    		bgcolor = params.get(:bgcolor);
    	}
        Drawable.initialize(params);
        // Load Resources
        background = Ui.loadResource(Rez.Drawables.id_background);
    }

    function draw(dc) {
    	dc.clear();
    	// Draw Background Color
    	dc.setColor(bgcolor, Gfx.COLOR_TRANSPARENT);
    	dc.fillRectangle(0,0,dc.getWidth(),dc.getHeight());
    	// Draw Background
        dc.drawBitmap(locX,locY,background);
    }
}