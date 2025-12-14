//
//  StopwatchView.swift
//  tyme-it
//
//  Created by Akhilesh Amle on 14/12/25.
//

import SwiftUI

struct StopwatchView: View {
    @StateObject private var viewModel = StopwatchViewModel()

    var body: some View {
        ZStack {
            // Orange background replaced with DSColor.background
            DSColor.background
                .ignoresSafeArea()

            VStack(spacing: 24) {
                StopwatchTimeText(viewModel.formattedTime)

                HStack(spacing: 16) {
                    Button(action: {
                        performStrongHaptic()
                        viewModel.toggle()
                    }) {
                        Image(systemName: viewModelIsRunning ? "pause.fill" : "play.fill")
                    }
                    .buttonStyle(PrimaryFilledButtonStyle())

                    Button(action: {
                        performStrongHaptic()
                        viewModel.reset()
                    }) {
                        Image(systemName: "arrow.counterclockwise")
                    }
                    .buttonStyle(SecondaryStrokeButtonStyle())
                    .disabled(viewModelIsRunning == false && viewModel.elapsed == 0)
                    .opacity((viewModelIsRunning == false && viewModel.elapsed == 0) ? 0.5 : 1)
                }
            }
            .padding()
        }
    }

    private var viewModelIsRunning: Bool { viewModelValue(\.isRunning) }

    private func viewModelValue<T>(_ keyPath: KeyPath<StopwatchViewModel, T>) -> T {
        viewModel[keyPath: keyPath]
    }

    @MainActor
    private func performStrongHaptic() {
        #if os(iOS)
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        #endif
    }
}

#Preview {
    StopwatchView()
}
