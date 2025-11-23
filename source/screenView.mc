import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Time.Gregorian;
import Toybox.Application;

class screenView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        setTimeDisplay();
	    setDateDisplay();
	    setBatteryDisplay();
        setPhoneConnectionDisplay();

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

    // Custom hidden functions
    hidden function setTimeDisplay() {
        // Get the current time and format it correctly
        var timeFormat = "$1$:$2$";
    	var clockTime = System.getClockTime();
        var hours = clockTime.hour;
        if (!System.getDeviceSettings().is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
        } else {
            if (Application.Properties.getValue("UseMilitaryFormat")) {
                timeFormat = "$1$$2$";
                hours = hours.format("%02d");
            }
        }
        var timeString = Lang.format(timeFormat, [hours, clockTime.min.format("%02d")]);

        // Update the view
        var setTimeDisplay = View.findDrawableById("TimeDisplay") as Text;
        setTimeDisplay.setColor(Application.Properties.getValue("ForegroundColor") as Number);
        setTimeDisplay.setText(timeString);
    }

    hidden function setDateDisplay() {        
    	var now = Time.now();
	    var date = Time.Gregorian.info(now, Time.FORMAT_LONG);
	    var dateString = Lang.format("$1$ $2$, $3$", [date.month, date.day, date.year]);

        // Update the view
        var dateDisplay = View.findDrawableById("DateDisplay") as Text;
        dateDisplay.setColor(Application.Properties.getValue("ForegroundColor") as Number);
	    dateDisplay.setText(dateString);
    }

    hidden function setBatteryDisplay() {
    	var battery = System.getSystemStats().battery;				

        // Update the view
        var batteryDisplay = View.findDrawableById("BatteryDisplay") as Text;
        batteryDisplay.setColor(Application.Properties.getValue("ForegroundColor") as Number);
	    batteryDisplay.setText(battery.format("%d")+"%");
    }

    hidden function setPhoneConnectionDisplay() {
    	var phoneConnected = System.getDeviceSettings().phoneConnected;
        var phoneConnectionDisplay = View.findDrawableById("PhoneConnectionDisplay") as Text;

        if (phoneConnected) {
            phoneConnectionDisplay.setColor(Application.Properties.getValue("ForegroundColor") as Number);
            // Use icon font character id 56 (bluetooth icon) from icons.fnt
            phoneConnectionDisplay.setText("\u0038");
        } else {
            phoneConnectionDisplay.setText("");
        }
    }
}
