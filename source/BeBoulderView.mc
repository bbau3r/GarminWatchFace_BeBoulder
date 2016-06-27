using Toybox.ActivityMonitor as Act;
using Toybox.Graphics as Gfx;
using Toybox.Lang as Lang;
using Toybox.System as Sys;
using Toybox.Time.Gregorian as Calendar;
using Toybox.WatchUi as Ui;

class BeBoulderView extends Ui.WatchFace {

	hidden var successString;
    function initialize() {
        WatchFace.initialize();
    }

    //! Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
        successString = Ui.loadResource(Rez.Strings.text_success);
    }

    //! Called when this View is brought to the foreground. Restore
    //! the state of this View and prepare it to be shown. This includes
    //! loading resources into memory.
    function onShow() {
    }

    //! Update the view
    function onUpdate(dc) {
        // Get general information from watch to display
        var clockTime = Sys.getClockTime();
        var dateInfo = Calendar.info(Time.now(), Time.FORMAT_MEDIUM);
        var actInfo = Act.getInfo();
        var settings = Sys.getDeviceSettings();
        
        // Format time based strings
        var dayString = Lang.format("$1$ $2$", [dateInfo.day_of_week, dateInfo.day]);
        var hourString = Lang.format("$1$", [getHour(settings.is24Hour, clockTime)]);
        var minString = Lang.format("$1$", [clockTime.min.format("%02d")]);
        
        // Set label to show current time
        View.findDrawableById("HourLabel").setText(hourString);
        View.findDrawableById("MinLabel").setText(minString);
        
        // Set success label
        var successLabelText = actInfo.steps >= actInfo.stepGoal ? successString : "";
        View.findDrawableById("SuccessLabel").setText(successLabelText);
 
        // Set label to show current date
        View.findDrawableById("DateLabel").setText(dayString);
        
        // Set Actionbar to show current status
        var actionBar = View.findDrawableById("ActionBar");
        actionBar.setStatus(Sys.getSystemStats().battery, settings.notificationCount, settings.alarmCount, settings.phoneConnected, false);
        
        // Set MoveBar to show if user needs to move
        View.findDrawableById("MoveBar").setMoveLevel(actInfo.moveBarLevel);
        
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    //! Called when this View is removed from the screen. Save the
    //! state of this View here. This includes freeing resources from
    //! memory.
    function onHide() {
    }

    //! The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    //! Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }
    
    //! Gets the current hour
    function getHour(is24Hour, clockTime) {
    	var hour = clockTime.hour;
    	if (!is24Hour) {
    		if (hour > 12) { return hour - 12; }
    		if (hour == 0) { return 12; }
    	}
    	return hour;
    }
}
