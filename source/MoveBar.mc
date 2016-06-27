using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;

class MoveBar extends Ui.Drawable {

	hidden var bgColor;
	hidden var color;
	hidden var moveLevel;
	
    function initialize(params) {
    	// Get parameters
    	if (params == null) { 
    		params = {}; 
    		color = Gfx.COLOR_WHITE;
    		bgColor = Gfx.COLOR_BLUE;
		}
		else {
			color = params.get(:color);
    		bgColor = params.get(:bgColor);
		}
        Drawable.initialize(params);
    }

    function draw(dc) {
        var width = dc.getWidth();
        var height = dc.getHeight();
        
        dc.setColor(bgColor, Gfx.COLOR_TRANSPARENT);
        dc.fillRectangle(0, height-16, width, 14);
        dc.setColor(color, Gfx.COLOR_TRANSPARENT);
        
        if (moveLevel > 0)
        {
        	drawMoveSegment(dc, 0, height-13, 66, true);
        	for ( var i = 0; i < moveLevel - 1; i += 1)
        	{
        		drawMoveSegment(dc, 66+(i*20), height-13, 20, false);
        	}
        }
    }
    
    function setMoveLevel(ml)
    {
    	moveLevel = ml;
    }
    
    hidden function drawMoveSegment(dc, x, y, length, closedEnd)
    {
    	var arrowX = x+length;
    	var arrowLength = 8;
    	dc.fillPolygon([[x,y],[x+arrowLength, y+4],[x,y+8],[x+arrowLength,y+8],[x+arrowLength,y]]);
    	if (closedEnd)
    	{
    		dc.fillRectangle(x, y, length-arrowLength, 8);
    	}
    	else
    	{
    		dc.fillRectangle(arrowLength+x, y, length-arrowLength-arrowLength, 8);
    	}
    	
    	dc.fillPolygon([[arrowX-arrowLength,y],[arrowX-arrowLength,y+8],[arrowX, y+4]]);
    }
}