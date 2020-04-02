--Cut rename and clean videos V1.0
--The video track should be over the region you want to split and rename. 
--Consolidate the whole edit region with the same length that all the videos.
--Select the first video of the session and run the script. It will rename, cut and clean the consolidate region. It will finish automatically
--To abort, please change app or close Edit window.

activate application "Pro Tools"
tell application "System Events"
	tell process "Pro Tools"
		set continue_script to 1
		repeat while (continue_script = 1)
			--Open the rename window
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
			
			key code 41 --Press Ñ (track down)
			
			keystroke "b"
			
			set flag to my rename_clip()
			if flag = false then --If error opening the window, exit applescript
				return
			end if
			
			keystroke "v" using {command down}
			key code 36 --Press enter
			--Check that the rename window has been closed
			set flag to my rename_clip_closed()
			if flag = false then --If error closing the window, exit applescript
				return
			end if
			
			
			keystroke "p" --Select video track
			key code 48 --Press tab
			
			set flag to my check_if_more_regions()
			if flag = 0 then
				set continue_script to 0
				display notification "All videos has been renamed." with title "Cut, rename and clean videos" subtitle "Processing complete." sound name "Frog"
				return --Finish the script
			else
				set continue_script to 1
				
			end if
			
			
			
			key code 41 --Press Ñ (track down)
			delay 0.1
			keystroke "a" --Delete the void space
			delay 0.1
			keystroke "p" --Select the video track
			delay 0.1
			key code 48 using {control down} --Select the next video to rename
			
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
