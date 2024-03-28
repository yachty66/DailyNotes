import AppKit
import Foundation

func checkAndCreateFolder() {
    DispatchQueue.global(qos: .background).async {
        let appleScriptCode = """
        tell application "Notes"
            if not (exists folder "DailyNotes") then
                make new folder with properties {name:"DailyNotes"}
            end if
        end tell
        """
        var error: NSDictionary?
        if let scriptObject = NSAppleScript(source: appleScriptCode) {
            let output = scriptObject.executeAndReturnError(&error)
            DispatchQueue.main.async {
                if let error = error {
                    print("AppleScript Error: \(error)")
                } else {
                    print("Successfully checked/created the 'DailyNotes' folder. Output: \(output)")
                }
            }
        }
    }
}
