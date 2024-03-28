import SwiftUI

@main
struct DailyNotesApp: App {
    // Initialize the application
    init() {
        // Check if application was running before
        // if isFirstLaunch() {
        //     showPermissionsInstructions()
        // }

        //requestAutomationPermissions()


        // Call the method to check and create the folder
        CreateFolder.checkAndCreateFolder()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}