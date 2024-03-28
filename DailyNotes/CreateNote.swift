import Foundation

func currentDate() -> String {
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yy"
    let formattedDate = formatter.string(from: date)
    return formattedDate
}

func createNote() async {
    await withCheckedContinuation { continuation in
        let date = currentDate()
        let appleScriptCode = """
        tell application "Notes"
            tell folder "DailyNotes"
                make new note with properties {name:"\(date)"}
            end tell
        end tell
        """

        var error: NSDictionary?
        if let scriptObject = NSAppleScript(source: appleScriptCode) {
            scriptObject.executeAndReturnError(&error)
            if let error = error {
                print("Error: \(error)")
                continuation.resume()
            } else {
                print("Note created with date: \(date)")
                continuation.resume()
            }
        }
    }
}
