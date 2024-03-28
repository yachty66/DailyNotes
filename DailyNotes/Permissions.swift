//
//  Permissions.swift
//  DailyNotes
//
//  Created by Max Hager on 28.03.24.
//

import Cocoa
import Foundation

// check if it's the first launch and if yes, ask for permissions
func isFirstLaunch() -> Bool {
    print("is first launch")
    requestAutomationPermissions()
    return true
    // let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
    // if launchedBefore {
    //     return false
    // } else {
    //     UserDefaults.standard.set(true, forKey: "launchedBefore")
    //     // Since it's the first launch, we attempt to request permissions
    //     requestAutomationPermissions()
    //     return true
    // }
}

func showPermissionsInstructions() {
    let alert = NSAlert()
    alert.messageText = "Permission Required"
    alert.informativeText = "This app requires permissions to control Notes and System Events for full functionality. Please go to System Preferences > Privacy & Security > Automation and enable permissions for this app."
    alert.alertStyle = .warning
    alert.addButton(withTitle: "OK")
    alert.runModal()
}

func requestAutomationPermissions() {
    // Attempt to execute an AppleScript that requires permissions
    let appleScriptString = """
    tell application "System Events"
        get name of every process
    end tell
    """
    var error: NSDictionary?
    if let scriptObject = NSAppleScript(source: appleScriptString) {
        scriptObject.executeAndReturnError(&error)
        if let error = error {
            print("Error requesting automation permissions: \(error)")
        } else {
            // Permission was granted and the script executed successfully
            print("Automation permissions granted.")
        }
    }
}
