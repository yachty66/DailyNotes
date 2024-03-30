tell application "Notes"
    if not (exists folder "DailyNotes") then
        make new folder with properties {name:"DailyNotes"}
    end if
    set currentDate to current date
    set dayOfWeek to weekday of currentDate as text
    set dateString to day of currentDate as text & "-" & (month of currentDate as number) as text & "-" & year of currentDate as text
    set headerTitle to dayOfWeek & ", " & dateString
    set dailyNotesFolder to folder "DailyNotes"
    
    -- Check if the folder is empty
    set noteList to notes of dailyNotesFolder
    if (count of noteList) is equal to 0 then
        set lastNote to missing value
    else
        set lastNote to the last note of dailyNotesFolder
    end if
    
    if lastNote is missing value or name of lastNote does not start with dayOfWeek & ", " & dateString then
        make new note at dailyNotesFolder with properties {name:headerTitle, body:""}
    end if
end tell