import SwiftUI
import UserNotifications

/// Represent a count down element with a button to start and pause the counter.
///
/// The time of the counter is expressed in seconds and will be graphically rendered according the `abbreviated` unit style of **DateComponentsFormatter** object.
struct TimerView: View {

    // MARK: - Public Properties
    @State public var seconds: TimeInterval
    public var notificationRequest: UNNotificationRequest?
    public var whenCompleted: () -> Void
    
    // MARK: - Private Properties
    @State private var isTimerActive: Bool = false
    @State private var canBeFired: Bool = true
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Timer")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(canBeFired ? counter(from: seconds) : "Completed")
                    .foregroundColor(.secondary)
                    .font(.callout)
                    .fontWeight(.bold)
                    .onReceive(timer){ _ in
                        if self.seconds > 0 && isTimerActive {
                            self.seconds -= 1
                        } else if self.seconds <= 0 {
                            canBeFired = false
                            isTimerActive = false
                            withAnimation {
                                whenCompleted()
                            }
                        }
                    }
            }
            
            Button {
                if isTimerActive {
                    self.timer.upstream.connect().cancel()
                    self.removeScheduledNotification()
                } else {
                    self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                    self.scheduleNotification()
                }
                isTimerActive.toggle()
            } label: {
                Image(systemName: isTimerActive ? "pause.fill" : "play.fill")
                    .foregroundColor(Color.white)
                    .padding(20)
                    .background(canBeFired ? Color.blue : Color.gray )
                    .clipShape(Circle())
            }
            .padding(.leading, 8)
            .disabled(canBeFired == false)
            
        }
        .padding(12)
        .background(Color(UIColor.systemGray5))
        .cornerRadius(8)
    }
    
    // MARK: - Private Methods
    
    /// Transform the seconds amount in a human readable count down.
    /// - Parameter seconds: Amount of time specified in TimeInterval.
    /// - Returns: A formatted string that represent the remaining time in positional unit style.
    private func counter(from seconds: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        formatter.unitsStyle = .abbreviated

        return formatter.string(from: seconds) ?? ""
    }
    
    private func scheduleNotification() {
        guard let request = notificationRequest else { return }
        
        let date = Calendar.current.date(byAdding: DateComponents(second: Int(seconds + 1)), to: Date())
        let dateInfo = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date!)

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: false)
        let notificationRequest = UNNotificationRequest(identifier: request.identifier, content: request.content, trigger: trigger)
        UNUserNotificationCenter.current().add(notificationRequest)
    }
    
    private func removeScheduledNotification() {
        guard let requestIdentifier = notificationRequest?.identifier else { return }

        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [requestIdentifier])
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(seconds: 5, notificationRequest: nil) { }
    }
}
