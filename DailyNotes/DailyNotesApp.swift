import SwiftUI

@main
struct DailyNotesApp: App {
    init() {
        Task {
            await checkAndCreateFolder()
            print("Folder checked/created")
            await createNote()
            print("Note created")
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}