import Foundation
import SwiftUI

// NotificationHandler.swift
class NotificationHandler {
    // every time i am closing and open my mac this functions are called
    var onWakeOrUnlock: (() -> Void)?


    //now every time the mac wakes up the timer should be starting again 
    init() {
        NSWorkspace.shared.notificationCenter.addObserver(
            forName: NSWorkspace.didWakeNotification,
            object: nil, queue: .main
        ) { [weak self] _ in
            self?.onWakeOrUnlock?()
        }

        NSWorkspace.shared.notificationCenter.addObserver(
            forName: NSWorkspace.screensDidWakeNotification,
            object: nil, queue: .main
        ) { [weak self] _ in
            self?.onWakeOrUnlock?()
        }
    }
}

// DailyNotesApp.swift
@main
struct DailyNotesApp: App {
    let notificationHandler = NotificationHandler()

    init() {
        Task {
            await checkAndCreateFolder()
            await createNote()
        }
        TimerManager.startDailyTaskTimer { [self] in
            await executeDailyTasks()
        }

        notificationHandler.onWakeOrUnlock = { [self] in
            handleWakeOrUnlock()
        }
    }

    var body: some Scene {
        Settings {
            EmptyView()
        }
    }

    func executeDailyTasks() async {
        await checkAndCreateFolder()
        await createNote()
    }

    func handleWakeOrUnlock() {
        print("mac woke up")
        TimerManager.startDailyTaskTimer { [self] in
            await executeDailyTasks()
        }
    }
}
