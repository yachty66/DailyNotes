tell application "Notes"
    -- Get the DailyNotes folder
    set dailyNotesFolder to first folder whose name is "DailyNotes"
    
    -- Get all notes
    set noteList to notes of dailyNotesFolder
    set latestNote to first item of noteList
    
    -- Show and activate
    activate
    show latestNote
end tell

delay 0.5

tell application "System Events"
    tell application process "Notes"
        -- Open in new window
        click menu item "Open Note in New Window" of menu "Window" of menu bar 1
        
        -- Position the window (optional)
        set position of front window to {100, 100}
    end tell
end tell

-- Close main Notes window
tell application "Notes"
    close (every window whose name is "Notes")
end tell