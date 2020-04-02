--Configure Strip Silence V1.1 activate application "Pro Tools"tell application "System Events"	tell process "Pro Tools"		set frontmost to true		set answer to the button returned of (display dialog "Select Strip Silence mode" buttons {"Initial Edit", "Separate Slates", "Cancel"} default button "Separate Slates" cancel button "Cancel")						if answer = "Initial Edit" then			my open_strip_silence() --Open the Strip Silence			set {xPS1, yPS1, xSS1, ySS1, xPS2, yPS2, xSS2, ySS2, xPS3, yPS3, xSS3, ySS3, xPS4, yPS4, xSS4, ySS4} to my get_positions() --Call the get_position and resets the values						--Send the positions of the mouse click. The first 8 are for reset and the other 8 are for click in the correct spot						my click_pos(xPS1 + (xSS1 div 3), yPS1 + (ySS1 div 2), xPS2 + (xSS2 div 10), yPS2 + (ySS2 div 2), xPS3 + (xSS3 div 10), yPS3 + (ySS3 div 2), xPS4 + (xSS4 div 10), yPS4 + (ySS4 div 2), xPS1 + (xSS1 div 1.76), yPS1 + (ySS1 div 2), xPS2 + (xSS2 div 80), yPS2 + (ySS2 div 2), xPS3 + (xSS3 div 90), yPS3 + (ySS3 div 2), xPS4 + (xSS4 div 90), yPS4 + (ySS4 div 2))						--Fine movement			set s2 to 35			repeat until s2 &gt; 39 and s2 &lt; 50				increment slider 2 of window "Strip Silence"				set s2 to s2 + 1			end repeat						set s3 to 35			repeat until s3 &lt; 18 and s3 &gt; 0				decrement slider 3 of window "Strip Silence"				set s3 to s3 - 1			end repeat						set s4 to 35			repeat until s4 &lt; 25 and s4 &gt; 0				decrement slider 4 of window "Strip Silence"				set s4 to s4 - 1			end repeat					else if answer = "Separate Slates" then --Separate Slates was chosen				my open_strip_silence() --Open the Strip Silence			set {xPS1, yPS1, xSS1, ySS1, xPS2, yPS2, xSS2, ySS2, xPS3, yPS3, xSS3, ySS3, xPS4, yPS4, xSS4, ySS4} to my get_positions() --Call the get_position and resets the values									--Send the positions of the mouse click. The first 8 are for reset and the other 8 are for click in the correct spot			my click_pos(xPS1 + (xSS1 div 5), yPS1 + (ySS1 div 2), xPS2 + (xSS2 div 8), yPS2 + (ySS2 div 2), xPS3 + (xSS3 div 6), yPS3 + (ySS3 div 2), xPS4 + (xSS4 div 6), yPS4 + (ySS4 div 2), xPS1 + (xSS1 div 1.8), yPS1 + (ySS1 div 2), xPS2 + (xSS2 div 5.2), yPS2 + (ySS2 div 2), xPS3 + (xSS3 div 12), yPS3 + (ySS3 div 2), xPS4 + (xSS4 div 12), yPS4 + (ySS4 div 2))						try				click button "Strip" of window "Strip Silence"			end try		end if	end tellend tell--This function opens strip silence. If it is already open, it does nothingon open_strip_silence()	activate application "Pro Tools"	tell application "System Events"		tell process "Pro Tools"			set frontmost to true			if exists (1st window whose name contains "Strip Silence") then				--Do nothing				return							else --Opening strip silence				keystroke "u" using {command down}				set timer to 0				repeat until (exists window "Strip Silence")										if timer = 10 then						display dialog "Can't open the Strip Silence window" with icon caution giving up after 2 buttons ("OK")						return					end if					set timer to timer + 1					delay 0.5									end repeat			end if					end tell	end tellend open_strip_silenceon get_positions()	tell application "System Events"		tell process "Pro Tools"			try				tell slider 1 of window "Strip Silence" --Threshold					set {xPositionS1, yPositionS1} to position					set {xSizeS1, ySizeS1} to size				end tell							end try						try				tell slider 2 of window "Strip Silence" --Min Strip Duration					set {xPositionS2, yPositionS2} to position					set {xSizeS2, ySizeS2} to size				end tell							end try						try				tell slider 3 of window "Strip Silence" --Clip Start Pad					set {xPositionS3, yPositionS3} to position					set {xSizeS3, ySizeS3} to size				end tell							end try						try				tell slider 4 of window "Strip Silence" --Click End Pad					set {xPositionS4, yPositionS4} to position					set {xSizeS4, ySizeS4} to size				end tell							end try						return {{xPositionS1}, {yPositionS1}, {xSizeS1}, {ySizeS1}, {xPositionS2}, {yPositionS2}, {xSizeS2}, {ySizeS2}, {xPositionS3}, {yPositionS3}, {xSizeS3}, {ySizeS3}, {xPositionS4}, {yPositionS4}, {xSizeS4}, {ySizeS4}}		end tell	end tellend get_positionson click_pos(x1r, y1r, x2r, y2r, x3r, y3r, x4r, y4r, x1, y1, x2, y2, x3, y3, x4, y4)	tell application "System Events"		tell process "Pro Tools"						--Invoke python			do shell script " 
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
END"					end tell	end tellend click_pos