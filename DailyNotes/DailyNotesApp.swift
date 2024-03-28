import SwiftUI

@main
struct DailyNotesApp: App {
    init() {
        checkAndCreateFolder()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}