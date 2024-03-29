import SwiftUI

@main
struct DailyNotesApp: App {
    init() {
        //on app launch folder and note is created
        Task{
            await checkAndCreateFolder()
            await createNote()
        }

        //after this start a timer which is firing every day 00:01 and if its time for the timer than executeDailyTasks is called

        startDailyTaskTimer {
            await self.executeDailyTasks()
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
