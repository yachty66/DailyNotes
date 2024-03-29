import SwiftUI

@main
struct DailyNotesApp: App {
    init() {
        // on app launch folder and note is created
        Task {
            await checkAndCreateFolder()
            await createNote()
        }
        startDailyTaskTimer { [self] in
            print("timer fired")
            await executeDailyTasks()
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    func executeDailyTasks() async {
        await checkAndCreateFolder()
        await createNote()
    }
}
