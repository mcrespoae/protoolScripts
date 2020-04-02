
tell application "System Events"
	tell process "Pro Tools"
		if exists (1st window whose name contains "Audio Suite: Gain") then
			--If the Gain window is already openned, just click the button
			my click_Analyze() --Call the sub-routine to click the button
			
		else
			--if not, open it and wait until it is opened. Then press the button. We create a variable to stop the loop if it hits 10 times
			set timer to 0
			click menu item "Gain" of menu of menu item "Avid" of menu "AudioSuite" of menu bar 1
			
			repeat until (exists window "Audio Suite: Gain")
				
				if timer = 10 then
					display dialog "Can't find the Gain window" with icon caution giving up after 2 buttons ("OK")
					return
				end if
				set timer to timer + 1
				delay 0.5
				
			end repeat
			my click_Analyze() --Call the sub-routine to click the button
		end if
	end tell
end tell

on click_Analyze()
	tell application "System Events"
		tell process "Pro Tools"
			click button "Analyze" of window "Audio Suite: Gain"
		end tell
	end tell
end click_Analyze
