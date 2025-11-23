import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

class Background extends WatchUi.Drawable {
    hidden var yellow, cyan, green, magenta, red, blue, black, white, grey20, grey40, grey60, grey75, grey80;

    function initialize(params as Dictionary) {
        Drawable.initialize(params);

        yellow = params.get(:yellow);
        cyan = params.get(:cyan);
        green = params.get(:green);
        magenta = params.get(:magenta);
        red = params.get(:red);
        blue = params.get(:blue);
        black = params.get(:black);
        white = params.get(:white);
        grey20 = params.get(:grey20);
        grey40 = params.get(:grey40);
        grey60 = params.get(:grey60);
        grey75 = params.get(:grey75);
        grey80 = params.get(:grey80);
    }

    function draw(dc as Dc) as Void {
        var height = dc.getHeight();
        var width = dc.getWidth();
        var thirteenthOfDeviceHeight = height / 13;
        var thirteenthOfDeviceWidth = width / 13;
        var sixteenthOfDeviceWidth = width / 16;
        var sixthOfDeviceWidth = width / 6;

        // Draw white in top bar of PM5544
        dc.setColor(white, white);
        dc.fillRectangle(0, 0, width, thirteenthOfDeviceHeight);
        dc.fillRectangle(0, thirteenthOfDeviceHeight, sixteenthOfDeviceWidth * 4, thirteenthOfDeviceHeight);
        dc.fillRectangle(sixteenthOfDeviceWidth * 12, thirteenthOfDeviceHeight, sixteenthOfDeviceWidth * 4, thirteenthOfDeviceHeight);
        dc.fillRectangle(sixteenthOfDeviceWidth * 3.5, thirteenthOfDeviceHeight * 2, sixteenthOfDeviceWidth * 9, thirteenthOfDeviceHeight);

        // Draw black in top bar of PM5544
        dc.setColor(black, white);
        dc.fillRectangle(sixteenthOfDeviceWidth * 4.5, thirteenthOfDeviceHeight * 2, 1, thirteenthOfDeviceHeight);

        // Draw contrast square wave of PM5544 (alternating black and grey75)
        var i = 0;
        while (i < 16) {
            dc.setColor((i % 2 == 0) ? black : grey75, white);
            dc.fillRectangle(sixteenthOfDeviceWidth * i, thirteenthOfDeviceHeight * 3, sixteenthOfDeviceWidth, thirteenthOfDeviceHeight);
            i += 1;
        }

        // Draw contrast color bars of PM5544
        var colors = [yellow, cyan, green, magenta, red, blue];
        i = 0;
        while (i < colors.size()) {
            dc.setColor(colors[i], white);
            dc.fillRectangle(sixthOfDeviceWidth * i, thirteenthOfDeviceHeight * 4, sixthOfDeviceWidth, thirteenthOfDeviceHeight * 2);
            i += 1;
        }

        // Draw a variant of sinusoidal definition lines of PM5544
        var j = 0;
        while (j < 30) {
            dc.setColor((j % 2 == 0) ? black : white, white);
            dc.fillRectangle(2 * j, thirteenthOfDeviceHeight * 7, 2, thirteenthOfDeviceHeight * 2);
            j += 1;
        }

        var k = 0;
        while (k < 30) {
            dc.setColor((k % 2 == 0) ? black : white, white);
            dc.fillRectangle(width - (2 * k), thirteenthOfDeviceHeight * 7, 2, thirteenthOfDeviceHeight * 2);
            k += 1;
        }

        // Draw grey scale bars of PM5544
        var grayscales = [black, grey20, grey40, grey60, grey80, white];
        i = 0;
        while (i < grayscales.size()) {
            dc.setColor(grayscales[i], white);
            dc.fillRectangle(sixthOfDeviceWidth * i, thirteenthOfDeviceHeight * 10, sixthOfDeviceWidth, thirteenthOfDeviceHeight);
            i += 1;
        }

        // Draw reflection check bottom bar of PM5544
        dc.setColor(white, white);
        dc.fillRectangle(0, thirteenthOfDeviceHeight * 11, sixteenthOfDeviceWidth * 3.5, thirteenthOfDeviceHeight);
        dc.fillRectangle(sixteenthOfDeviceWidth * 12.5, thirteenthOfDeviceHeight * 11, sixteenthOfDeviceWidth * 3.5, thirteenthOfDeviceHeight);
        dc.fillRectangle(sixteenthOfDeviceWidth * 4.5, thirteenthOfDeviceHeight * 11, 1, thirteenthOfDeviceHeight);

        // Draw y/c timing check of PM5544
        dc.setColor(yellow, white);
        dc.fillRectangle(0, thirteenthOfDeviceHeight * 12, thirteenthOfDeviceWidth * 6, thirteenthOfDeviceHeight * 2);
        dc.fillRectangle(thirteenthOfDeviceWidth * 7, thirteenthOfDeviceHeight * 12, thirteenthOfDeviceWidth * 6, thirteenthOfDeviceHeight * 2);

        dc.setColor(red, white);
        dc.fillRectangle(thirteenthOfDeviceWidth * 6, thirteenthOfDeviceHeight * 12, thirteenthOfDeviceWidth, thirteenthOfDeviceHeight * 2);
    }
}