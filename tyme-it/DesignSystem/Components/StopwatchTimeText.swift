//
//  StopwatchTimeText.swift
//  tyme-it
//
//  Created by Akhilesh Amle on 14/12/25.
//

import SwiftUI

public struct StopwatchTimeText: View {
    private let text: String

    public init(_ text: String) {
        self.text = text
    }

    public var body: some View {
        Text(text)
            .font(DSTypography.timeLarge())
            .monospacedDigit()
            .foregroundStyle(DSColor.charcoal)
    }
}

#Preview {
    StopwatchTimeText("stopwatch")
}
