tell application "Notes"
    -- Get the DailyNotes folder
    set dailyNotesFolder to first folder whose name is "DailyNotes"
    
    -- Get all notes
    set noteList to notes of dailyNotesFolder
    
    -- Get first note from the list
    set latestNote to first item of noteList
    
    -- Bring Notes to front and show the note
    activate
    show latestNote
end tell