//
//  TimeComponents.swift
//  Recipe Book
//
//  Created by Luca Casula on 16/05/25.
//

import SwiftUI

class TimeComponents: ObservableObject {
    @Published var hour: Int = 0 {
        didSet { updateTotalSeconds() }
    }
    @Published var minute: Int = 0 {
        didSet { updateTotalSeconds() }
    }
    @Published var second: Int = 0 {
        didSet { updateTotalSeconds() }
    }

    var onUpdate: ((Int) -> Void)?

    private func updateTotalSeconds() {
        let total = hour * 3600 + minute * 60 + second
        onUpdate?(total)
    }

    func setFromTotal(seconds: Int) {
        hour = seconds / 3600
        minute = (seconds % 3600) / 60
        second = seconds % 60
    }
}
