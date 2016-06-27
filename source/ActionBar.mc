using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;

class ActionBar extends Ui.Drawable {
	
	hidden var actionBarFont;
	hidden var justification;
	hidden var color;
	hidden var emptyColor;
	
	hidden var battery;
	hidden var notifications;
	hidden var alarms;
	hidden var isPhoneConnected;
	hidden var isDoNotDisturb;
	
    function initialize(params) {
    	// Get parameters
    	if (params == null) { 
    		params = {}; 
    		justification = Gfx.TEXT_JUSTIFY_RIGHT;
    		color = Gfx.COLOR_WHITE;
    		emptyColor = Gfx.COLOR_RED;
		}
		else {
			justification = params.get(:justification);
			color = params.get(:color);
			emptyColor = params.get(:emptyColor);
		}
        Drawable.initialize(params);
        
        // Load Resources
        actionBarFont = Ui.loadResource(Rez.Fonts.id_actionBar);
        
        // Set Defaults
        battery = 100;
        notifications = 0;
    	alarms = 0;
    	isPhoneConnected = false;
    	isDoNotDisturb = false;
    }

    function draw(dc) {
        var width = dc.getWidth();
        var height = dc.getHeight();
        dc.setColor(color, Gfx.COLOR_TRANSPARENT);
        if (justification == Gfx.TEXT_JUSTIFY_RIGHT) {
        	dc.drawText(width-28, 2, actionBarFont, getStatusText(), justification);
        } else if (justification == Gfx.TEXT_JUSTIFY_LEFT) {
        	dc.drawText(4, 2, actionBarFont, getStatusText(), justification);
        } else {
        	dc.drawText(width/2, 2, actionBarFont, getStatusText(), Gfx.TEXT_JUSTIFY_CENTER);
        }
        drawBattery(dc, width-24, 5);
    }
    
    //! Sets the status of the action bar
    //! @param battery Float value representing current battery value between 0-100
    //! @param notificationCount Number of notifications user has recieved
    //! @param alarmCount Number of alarms currently active
    //! @param phoneConnected Boolean value if the watch is connected to the phone through bluetooth
    //! @param doNotDisturb Boolean value if do not disturb mode is enabled, currently not part of the sdk...
    function setStatus(batteryLife, notificationCount, alarmCount, phoneConnected, doNotDisturb) {
    	battery = batteryLife;
    	notifications = notificationCount;
    	alarms = alarmCount;
    	isPhoneConnected = phoneConnected;
    	isDoNotDisturb = doNotDisturb;
    }
    
    hidden function getStatusText() {
    	var ret = "";
    	if (isDoNotDisturb) { ret+=" 3 "; }
    	if (notifications > 0) { ret+=" 0 "; }
    	if (alarms > 0) { ret+=" 1 "; }
    	if (isPhoneConnected) { ret+=" 2 "; }
    	return ret;
    }
    
    hidden function drawBattery(dc, x, y) {
		if (battery < 5) {
			dc.setColor(emptyColor, Gfx.COLOR_TRANSPARENT);
		}
		dc.drawRectangle(x, y, 16, 8);
		dc.drawRectangle(x+16, y+2, 2, 4);
		dc.fillRectangle(x, y, 16*battery/100, 8);
    }
}