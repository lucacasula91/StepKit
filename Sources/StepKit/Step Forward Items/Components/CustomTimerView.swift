//
//  CustomTimerView.swift
//  StepKit
//
//  Created by Luca Casula on 18/05/25.
//


import SwiftUI

struct CustomTimerView: View {

    // MARK: - Properties
    var timerName: String
    var onCompletion: () -> Void
    init(timerName: String, completion: @escaping () -> Void) {
        self.timerName = timerName
        onCompletion = completion
    }

    @Namespace var namespaceAnimation

    @State private var timerSeconds: CGFloat = 0
    @State private var completedSeconds: TimeInterval = 0
    @State private var timerHasBeenSetted: Bool = false

    @State private var isTimerActive = false
    @State private var canBeFired = true
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var backgroundDate: Date?
    @State private var componentWidth: CGFloat = .infinity

    @Environment(\.scenePhase) var scenePhase
    @Environment(\.sizeCategory) var sizeCategory

    // MARK: - Body
    var body: some View {
        VStack(alignment: .trailing) {
            
            if timerHasBeenSetted == false {
                GeometryReader { geometry in
                    let size = geometry.size
                    let horizontalPadding = size.width / 2
                    
                    ScrollableTimerView(
                        steps: 10,
                        horizontalPadding: horizontalPadding,
                        height: sizeCategory.isAccessibilityCategory ? 120 : 70,
                        onOffsetChange: handleScrollOffsetChange
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .frame(height: size.height)
                }
                .frame(height: sizeCategory.isAccessibilityCategory ? 120 : 70)
                .transition(.opacity.combined(with: .move(edge: .trailing)))
            }

                HStack {
                    VStack(alignment: .trailing) {
                        Text(timerName)
                            .proxyFont(.body, bold: true)

                        if #available(iOS 16.6, *) {
                            timerLabel
                                .contentTransition(.numericText())
                            
                        } else {
                            timerLabel
                        }
                    }
                    
                    Button {
                        withAnimation(.bouncy) {
                            if isTimerActive {
                                timer.upstream.connect().cancel()
                                removeScheduledNotification()
                            } else {
                                timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                                scheduleNotification()
                                if timerHasBeenSetted == false {
                                    timerHasBeenSetted.toggle()
                                }
                            }

                            withAnimation() {
                                isTimerActive.toggle()
                            }
                        }
                    } label: {
                        Image(systemName: isTimerActive ? "pause.fill" : "play.fill")
                            .foregroundColor(Color.white)
                            .padding(20)
                            .background(canBeFired ? Color.accentColor : Color.gray )
                            .clipShape(Circle())
                    }
                    .padding(.leading, 8)
                    .disabled(canBeFired == false)
                    .fixedSize()
                
            }
        }
        

    }

    private var timerLabel: some View {
        Text(descriptiveTimeRangeFrom(seconds: timerSeconds))
            .proxyFont(.title3, bold: true)
            .onReceive(timer) { _ in
                if timerSeconds > 0 && isTimerActive {
                    withAnimation() {
                        timerSeconds = CGFloat(Int(timerSeconds) - 1)
                    }
                } else if timerSeconds <= 0 && timerHasBeenSetted  {
                    canBeFired = false
                    isTimerActive = false
                    withAnimation {
                        onCompletion()
                    }
                }
            }
            .matchedGeometryEffect(id: "timeLabel", in: namespaceAnimation)
    }
    
    // MARK: - Methods
    
    private func handleScenePhaseChange(_ newPhase: ScenePhase) {
        guard isTimerActive else { return }
        
        switch newPhase {
        case .active:
            let now = Date()
            let inactivityDuration = TimerScenePhases.getInactivitySecondsTill(activeDate: now)
            timerSeconds = max(0, timerSeconds - inactivityDuration)
        case .background:
            TimerScenePhases.backgroundDate = Date()
        default:
            break
        }
    }

    private func handleScrollOffsetChange(_ newOffset: CGFloat) {
        guard newOffset >= 0 else {
            timerSeconds = 0
            return
        }

        let convertedOffset = newOffset / 50
        withAnimation() {
            timerSeconds = convertedOffset * 60
        }
    }

    private func descriptiveTimeRangeFrom(seconds: Double) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated

        if let formattedString = formatter.string(from: seconds) {
            return formattedString
        } else {
            return "0s"
        }
    }

    private func scheduleNotification() {
        //        guard let request = notificationRequest else { return }
        //
        //        let date = Calendar.current.date(byAdding: DateComponents(second: Int(seconds + 1)), to: Date())
        //        let dateInfo = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date!)
        //
        //        let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: false)
        //        let notificationRequest = UNNotificationRequest(identifier: request.identifier, content: request.content, trigger: trigger)
        //        UNUserNotificationCenter.current().add(notificationRequest)
    }

    private func removeScheduledNotification() {
        //        guard let requestIdentifier = notificationRequest?.identifier else { return }
        //
        //        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [requestIdentifier])
    }
}

import SwiftUI

struct ScrollableTimerView: View {
    let steps: Int
    let horizontalPadding: CGFloat
    let height: CGFloat
    let onOffsetChange: (CGFloat) -> Void

    struct ViewOffsetKey: PreferenceKey {
        static var defaultValue: CGFloat = 0
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value += nextValue()
        }
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 5) {
                let totalSteps = steps * 60 + 1

                ForEach(0..<totalSteps, id: \.self) { index in
                    let isMajorTick = index % steps == 0

                    Divider()
                        .background(isMajorTick ? Color.primary : .gray)
                        .frame(width: 0, height: isMajorTick ? 20 : 10)
                        .overlay(alignment: .top) {
                            if isMajorTick {
                                Text("\(index / steps)")
                                    .proxyFont(.body, bold: true)
                                    .offset(y: 24)
                                    .fixedSize()
                            }
                        }
                }
            }
            .frame(height: height)
            .padding(.horizontal, horizontalPadding)
            .background(
                GeometryReader {
                    Color.clear.preference(key: ViewOffsetKey.self,
                                           value: -$0.frame(in: .named("scroll")).origin.x)
                }
            )
            .onPreferenceChange(ViewOffsetKey.self, perform: onOffsetChange)
        }
        .mask(
            LinearGradient(colors: [.black.opacity(0), .black, .black.opacity(0)],
                           startPoint: .leading, endPoint: .trailing)
            .padding(.horizontal, 30)
        )
        .overlay {
            Image(systemName: "arrowtriangle.down.fill")
                .resizable()
                .frame(width: 12, height: 12)
                .offset(y: -22)
        }
        .coordinateSpace(name: "scroll")
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}



// MARK: - Preview
@available(iOS 17.0, *)
#Preview {
    CustomTimerView(timerName: "Timer pasta") {}

}
