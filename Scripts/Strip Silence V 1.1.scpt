--Configure Strip Silence V1.1 
			/usr/bin/python &lt;&lt;END

from Quartz.CoreGraphics import CGEventCreateMouseEvent
from Quartz.CoreGraphics import kCGMouseButtonLeft
from Quartz.CoreGraphics import CGEventPost
from Quartz.CoreGraphics import kCGHIDEventTap
from Quartz.CoreGraphics import kCGEventMouseMoved
from Quartz.CoreGraphics import kCGEventLeftMouseDown
from Quartz.CoreGraphics import kCGEventLeftMouseUp
from Quartz.CoreGraphics import CGEventCreate
from Quartz.CoreGraphics import CGEventGetLocation



def mouseEvent(type, posx, posy):
	position = (posx, posy)
	theEvent = CGEventCreateMouseEvent(None, type, position, kCGMouseButtonLeft)
	CGEventPost(kCGHIDEventTap, theEvent)

def mousemove(posx,posy):
	mouseEvent(kCGEventMouseMoved, posx,posy);

def mouseclick(posx,posy):
	mouseEvent(kCGEventLeftMouseDown, posx,posy);
	mouseEvent(kCGEventLeftMouseUp, posx,posy);

ourEvent = CGEventCreate(None); 
currentpos = CGEventGetLocation(ourEvent);             # Save current mouse position

#Reset the sliders
mouseclick(" &amp; x1r &amp; "," &amp; y1r &amp; ");
mouseclick(" &amp; x2r &amp; "," &amp; y2r &amp; ");
mouseclick(" &amp; x3r &amp; "," &amp; y3r &amp; ");
mouseclick(" &amp; x4r &amp; "," &amp; y4r &amp; ");

#Click in the spots
mouseclick(" &amp; x1 &amp; "," &amp; y1 &amp; ");
mouseclick(" &amp; x2 &amp; "," &amp; y2 &amp; ");
mouseclick(" &amp; x3 &amp; "," &amp; y3 &amp; ");
mouseclick(" &amp; x4 &amp; "," &amp; y4 &amp; ");

mousemove(int(currentpos.x),int(currentpos.y));      # Restore mouse position
END"