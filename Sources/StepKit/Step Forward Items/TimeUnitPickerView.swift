//
//  TimeUnitPickerView.swift
//  Recipe Book
//
//  Created by Luca Casula on 16/05/25.
//


import SwiftUI

struct TimeUnitPickerView: View {
    let range: Range<Int>
    @Binding var selection: Int
    let unitLabel: String

    var body: some View {
        ZStack {
            Picker(unitLabel, selection: $selection) {
                ForEach(range, id: \.self) {
                    Text("\($0)")
                        .offset(x: -20)
                        .multilineTextAlignment(.trailing)
                }
            }
            .pickerStyle(.wheel)

            Text(unitText(for: selection))
                .offset(x: 18)
        }
    }

    private func unitText(for value: Int) -> String {
        if ["ore", "hours"].contains(unitLabel.lowercased()) {
            return value == 1 ? "ora" : "ore"
        }
        return unitLabel
    }
}

