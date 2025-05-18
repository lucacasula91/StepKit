//
//  CustomTimePickerView.swift
//  Recipe Book
//
//  Created by Luca Casula on 16/05/25.
//

import SwiftUI

struct CustomTimePickerView: View {
    @Binding var totalSeconds: Int
    @StateObject private var time = TimeComponents()

    var body: some View {
        HStack {
            TimeUnitPickerView(
                range: 0..<24,
                selection: $time.hour,
                unitLabel: "ore"
            )
            
            TimeUnitPickerView(
                range: 0..<60,
                selection: $time.minute,
                unitLabel: "min"
            )
            
            TimeUnitPickerView(
                range: 0..<60,
                selection: $time.second,
                unitLabel: "sec"
            )
        }
        .onAppear {
            time.setFromTotal(seconds: totalSeconds)
            time.onUpdate = { newValue in
                totalSeconds = newValue
            }
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    
    @Previewable @State var seconds: Int = 0
    
    NavigationStack {
        CustomTimePickerView(totalSeconds: $seconds)
    }
    
}
