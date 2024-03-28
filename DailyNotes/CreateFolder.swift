import Foundation

func checkAndCreateFolder() async {
    await withCheckedContinuation { continuation in
        let appleScriptCode = """
        tell application "Notes"
            if not (exists folder "DailyNotes") then
                make new folder with properties {name:"DailyNotes"}
            end if
        end tell
        """
        var error: NSDictionary?
        if let scriptObject = NSAppleScript(source: appleScriptCode) {
            scriptObject.executeAndReturnError(&error)
            if let error = error {
                print("AppleScript Error: \(error)")
                continuation.resume()
            } else {
                print("Successfully checked/created the 'DailyNotes' folder.")
                continuation.resume()
            }
        }
    }
}