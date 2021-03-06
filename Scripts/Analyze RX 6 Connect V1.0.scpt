tell application "System Events"
	tell process "Pro Tools"
		if exists (1st window whose name contains "Audio Suite: RX 6 Connect") then
			--If the window is RX is already openned, just click the button
			click button "Analyze" of window "Audio Suite: RX 6 Connect"
			
		else
			--if not, open it and wait until it is opened. Then press the button. We create a variable to stop the loop if it hits 10 times
			set timer to 0
			click menu item "RX 6 Connect" of menu of menu item "iZotope, Inc." of menu "AudioSuite" of menu bar 1
			
			repeat until (exists window "Audio Suite: RX 6 Connect")
				
				if timer = 10 then
					display dialog "Can't find the RX window" with icon caution giving up after 2 buttons ("OK")
					return
				end if
				set timer to timer + 1
				delay 0.5
				
			end repeat
			
			click button "Analyze" of window "Audio Suite: RX 6 Connect"
		end if
	end tell
end tell
