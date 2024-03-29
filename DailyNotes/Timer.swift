import Foundation

class TimerManager {
    static var currentTimer: Timer?

    static func startDailyTaskTimer(completion: @escaping () async -> Void) {
        // Invalidate and nullify the existing timer if it exists
        currentTimer?.invalidate()
        currentTimer = nil

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
            }
        }
    }
}