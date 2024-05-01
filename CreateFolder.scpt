tell application "Notes"
    if not (exists folder "DailyNotes") then
        make new folder with properties {name:"DailyNotes"}
    end if
    set currentDate to current date
    set dayOfWeek to weekday of currentDate as text
    set dateString to day of currentDate as text & "-" & (month of currentDate as number) as text & "-" & year of currentDate as text
    set headerTitle to dayOfWeek & ", " & dateString
    set dailyNotesFolder to folder "DailyNotes"
    
    -- Check all notes for existing header
    set noteList to notes of dailyNotesFolder
    set noteExists to false
    repeat with aNote in noteList
        if name of aNote starts with headerTitle then
            set noteExists to true
            exit repeat
        end if
    end repeat
    
    -- Create a new note only if no existing note with today's date as header
    if noteExists is false then
        make new note at dailyNotesFolder with properties {name:headerTitle, body:""}
    end if
end tell