import Foundation

class TimerManager {
    static var currentTimer: Timer?
    static let userDefaults = UserDefaults.standard
    static let lastExecutionKey = "lastExecutionDate"

    static func startDailyTaskTimer(completion: @escaping () async -> Void) {
        // Invalidate and nullify the existing timer if it exists
        currentTimer?.invalidate()
        currentTimer = nil

        // Check if the task was missed and execute it if necessary
        checkAndExecuteMissedTask(completion: completion)

        let calendar = Calendar.current
        let now = Date()
        var nextRun = calendar.date(bySettingHour: 0, minute: 1, second: 0, of: now)!
        if nextRun <= now {
            nextRun = calendar.date(byAdding: .day, value: 1, to: nextRun)!
        }

        let initialDelay = nextRun.timeIntervalSince(now)
        let daily = TimeInterval(24 * 60 * 60) // 24 hours in seconds

        DispatchQueue.main.asyncAfter(deadline: .now() + initialDelay) {
            Task {
                await completion()
            }

            // Schedule a new timer and store its reference
            currentTimer = Timer.scheduledTimer(withTimeInterval: daily, repeats: true) { _ in
                Task {
                    await completion()
                }
                // Update the last execution date
                userDefaults.set(Date(), forKey: lastExecutionKey)
            }
        }
    }

    static func checkAndExecuteMissedTask(completion: @escaping () async -> Void) {
        guard let lastExecutionDate = userDefaults.object(forKey: lastExecutionKey) as? Date else {
            // If there's no recorded last execution, run the task immediately
            Task {
                await completion()
            }
            return
        }

        let calendar = Calendar.current
        if let nextScheduledDate = calendar.date(byAdding: .day, value: 1, to: lastExecutionDate),
           nextScheduledDate < Date()
        {
            // If the next scheduled date is in the past, the task was missed
            Task {
                await completion()
            }
        }
    }
}
