--Spotting Videos V1.0
--The OST track must be under the video track. The first video has to be spotted correctly.
--Select the first video of the session and run the script. It will create a marker and spot all subsequent videos to rounded up TCs. It will finish automatically
--To abort, please change app or close Edit window.

activate application "Pro Tools"
tell application "System Events"
	tell process "Pro Tools"
		
		
		set continue_script to 1
		repeat while (continue_script &gt; -1)
			key code 41 using {shift down} --Select the audio region below 
			keystroke "t" using {command down} --Delete excess length in the audio clip
			key code 41 using {control down, option down} --Unselect the audio region below 
			
			set flag to my rename_clip()
			if flag = false then --If error opening the window, exit applescript
				return
			end if
			
			keystroke "c" using {command down} --Copy the name
			key code 53 --Press Esc
			
			--Check that the rename window has been closed
			set flag to my rename_clip_closed()
			if flag = false then --If error closing the window, exit applescript
				return
			end if
			
			key code 76 --Creates a marker
			
			set flag to my create_marker()
			if flag = false then --If error opening the window, exit applescript
				return
			end if
			
			keystroke "v" using {command down}
			key code 36 --Press enter
			
			--Check that the rename window has been closed
			set flag to my create_marker_closed()
			if flag = false then --If error closing the window, exit applescript
				return
			end if
			
			if continue_script = 0 then
				display notification "All videos has been placed." with title "Spotting videos" subtitle "Processing complete." sound name "Frog"
				return --Finish the script
			end if
			
			
			
			key code 48 using {control down} --Press control + tab (select next video)
			
			key code 41 using {shift down} --Select the audio region below 
			
			keystroke "t" using {command down} --Delete excess length in the audio clip
			
			key code 36 using {option down, shift down} --Press enter. Select all subsequent videos
			
			delay 1
			
			keystroke "x" --Cut the video region
			
			keystroke "l" --Go back to the previous video
			
			key code 67 --Press * to selec TC
			
			key code 124 --Press right arrow to select hours
			
			key code 124 --Press right arrow to select minutes
			
			key code 126 --Press up arrow to increase one minute
			
			key code 126 --Press up arrow to increase one minute
			
			key code 124 --Press right arrow to select seconds
			
			key code 82 --Press 0 to replace seconds and ms
			
			key code 76 --Press enter to accept the new TC for the new video
			
			keystroke "v" using {command down} --Paste the video and audio to the new location
			
			key code 41 using {control down, option down} --Unselect the audio region below 
			
			key code 48 --Press tab to go to the end of the video
			
			set flag to my check_if_more_regions()
			if flag = 0 then
				set continue_script to continue_script - 1 --When it finds the end, the variable will have a 0 value and the script will finish after the next marker
			else
				set continue_script to 1
			end if
			
			key code 48 using {control down, option down} --Press control, alt + tab (select previous video)
			
		end repeat
		
	end tell
end tell



on rename_clip()
	
	activate application "Pro Tools"
	tell application "System Events"
		tell process "Pro Tools"
			click menu item "Rename..." of menu "Clip" of menu bar 1
			if not (exists (1st window whose name contains "Name")) then
				keystroke "d" using {command down, shift down} --Clean Find clips
				click menu item "Rename..." of menu "Clip" of menu bar 1
				if not (exists (1st window whose name contains "Name")) then
					keystroke "3" using {command down, shift down} --Show video on clips
					click menu item "Rename..." of menu "Clip" of menu bar 1
				end if
				if not (exists (1st window whose name contains "Name")) then
					keystroke "1" using {command down, shift down} --Show audio on clips
					click menu item "Rename..." of menu "Clip" of menu bar 1
				end if
				
				if not (exists (1st window whose name contains "Name")) then
					set timer to 0
					repeat until (exists (1st window whose name contains "Name"))
						if timer = 10 then
							keystroke "1" using {command down, shift down}
							keystroke "3" using {command down, shift down}
							display dialog "Can't open Rename window" with icon caution giving up after 2 buttons ("OK")
							return false --Error
						end if
						set timer to timer + 1
						delay 0.05
					end repeat
				end if
			end if
		end tell
	end tell
	return true
end rename_clip


on rename_clip_closed()
	activate application "Pro Tools"
	tell application "System Events"
		tell process "Pro Tools"
			set timer to 0
			repeat until (not (exists (1st window whose name contains "Name")))
				if timer = 5 then
					display dialog "Can't close Rename window" with icon caution giving up after 2 buttons ("OK")
					return false
				end if
				set timer to timer + 1
				delay 0.05
			end repeat
		end tell
	end tell
	return true
end rename_clip_closed

on create_marker()
	activate application "Pro Tools"
	tell application "System Events"
		tell process "Pro Tools"
			
			if (not (exists (1st window whose name contains "New Memory Location"))) then
				set timer to 0
				repeat until (exists (1st window whose name contains "New Memory Location"))
					if timer = 10 then
						display dialog "Can't open New Memory Location window" with icon caution giving up after 2 buttons ("OK")
						return false --Error
					end if
					set timer to timer + 1
					delay 0.05
				end repeat
			end if
		end tell
	end tell
	return true
end create_marker


on create_marker_closed()
	activate application "Pro Tools"
	tell application "System Events"
		tell process "Pro Tools"
			set timer to 0
			repeat until (not (exists (1st window whose name contains "New Memory Location")))
				if timer = 5 then
					display dialog "Can't close New Memory Location window" with icon caution giving up after 2 buttons ("OK")
					return false
				end if
				set timer to timer + 1
				delay 0.05
			end repeat
		end tell
	end tell
	return true
end create_marker_closed


on check_if_more_regions()
	activate application "Pro Tools"
	tell application "System Events"
		tell process "Pro Tools"
			key code 81 --Select TC
			keystroke "c" using {command down} --Copy the TC
			delay 0.2
			key code 53 --Press Esc to deselect the TC
			
			set theTimeBefore to (the clipboard) --Creates a variable to store the TC
			delay 0.4
			
			key code 48 using {control down} --Press control + tab (select next region)
			key code 81 --Select TC again
			keystroke "c" using {command down} --Copy the TC
			delay 0.2
			key code 53 --Press Esc to deselect the TC
			
			set theTimeAfter to (the clipboard) --Creates a variable to store the TC
			delay 0.4
			
			if theTimeBefore = theTimeAfter then
				return 0 --Stop the script because we finished renaming the videos
			else
				return 1 --Continue the script because there are more videos to rename
			end if
			
		end tell
	end tell
end check_if_more_regions
