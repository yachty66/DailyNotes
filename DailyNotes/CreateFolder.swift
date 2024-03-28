import AppKit
import Foundation

class CreateFolder {
    // create
    func isFirstLaunch() -> Bool {
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore {
            return false
        } else {
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            return true
        }
    }

    static func checkAndCreateFolder() {
        print("check and create folder")
        // if this function runs i first need to check if i have already automation permission and if this is not the case i need to ask the user for permission
        DispatchQueue.global(qos: .background).async {
            let appleScriptCode = """
            tell application "Notes"
                if not (exists folder "DailyNotes") then
                    make new folder with properties {name:"DailyNotes"}
                end if
            end tell
            """

            var error: NSDictionary?
            if let scriptObject = NSAppleScript(source: appleScriptCode) { // Corrected variable name here
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
}
