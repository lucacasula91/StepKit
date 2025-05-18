//
//  CustomTimerView.swift
//  StepKit
//
//  Created by Luca Casula on 18/05/25.
//


import SwiftUI
struct CustomTimerView: View {
    
    var configuration: Configuration
    @State private var offset = CGFloat.zero
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            let horizontalPadding = size.width / 2
            
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing: configuration.spacing) {
                    let totalSteps = configuration.steps * configuration.count
                    ForEach(0...totalSteps, id: \.self) { index in
                        
                        let reminder = index % configuration.steps
                        
                        Divider()
                            .background(reminder == 0 ? Color.primary : .gray)
                            .frame(width: 0, height: reminder == 0 ? 20 : 10, alignment: .center)
                            .frame(maxHeight: 20, alignment: .bottom)
                            .overlay(alignment: .bottom) {
                                if reminder == 0 && configuration.showText {
                                    Text("\(index / configuration.steps)")
                                        .font(.caption)
                                        .offset(y: 20)
                                        .fixedSize()
                                }
                            }
                    }
                }
                .frame(height: size.height)
                .padding(.horizontal, horizontalPadding)
                .background(GeometryReader {
                    Color.clear.preference(key: ViewOffsetKey.self,
                                           value: -$0.frame(in: .named("scroll")).origin.x)
                })
                .onPreferenceChange(ViewOffsetKey.self) { offset = $0 / 50 }
                
            }
            .coordinateSpace(name: "scroll")
            .overlay() {
                Text(descriptiveTimeRangeFrom(seconds: Double(60 * offset)))
                    .offset(y: -40)
                
                Rectangle()
                    .frame(width: 1, height: 40)
                    .offset(y: -10)
            }
        }
    }
    
    func descriptiveTimeRangeFrom(seconds: Double) -> String {
        let totalSeconds = Int(seconds.rounded())
        let minutes = totalSeconds / 60
        let remainingSeconds = totalSeconds % 60

        var components: [String] = []

        if minutes > 0 {
            components.append("\(minutes)m")
        }

        components.append("\(remainingSeconds)s")

        return components.joined(separator: "  ")
    }
    
    struct ViewOffsetKey: PreferenceKey {
        typealias Value = CGFloat
        static var defaultValue = CGFloat.zero
        static func reduce(value: inout Value, nextValue: () -> Value) {
            value += nextValue()
        }
    }
    
    struct Configuration: Equatable {
        var count: Int
        var steps: Int = 10
        var spacing: CGFloat = 5
        var showText: Bool = true
    }
}



@available(iOS 17.0, *)
#Preview {
    @Previewable @State var configuration: CustomTimerView.Configuration = .init(count: 59)
    CustomTimerView(configuration: configuration)
    
    
}
