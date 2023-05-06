import SwiftUI

/// Keeps track of time interval between Scene phases changes.
struct TimerScenePhases {
    
    /// Date object of when the app entered in background mode.
    static var backgroundDate: Date?

    /// Calculate the time interval between `backgroundDate` object and `activeDate` object.
    /// - Parameter activeDate: Date object of when the app returns active.
    /// - Returns: TimeInterval object that represent the amound of seconds of app in background mode.
    static func getInactivitySecondsTill(activeDate: Date) -> TimeInterval {
        var output = TimeInterval(0)
        
        if
            let backgroundDate = backgroundDate,
            let secondsToRemove = Calendar.current.dateComponents([.second], from: backgroundDate, to: activeDate).second {
            output = TimeInterval(abs(secondsToRemove))
        }
        return output
    }
}
