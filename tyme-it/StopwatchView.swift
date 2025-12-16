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
        GeometryReader { proxy in
            let minSide = min(proxy.size.width, proxy.size.height)
            let circleDiameter = max(minSide - CGFloat(DSSpacing.s16), 0)

            ZStack {
                // Background: design system black
                DSColor.charcoal
                    .ignoresSafeArea()

                // Background circle: design system orange, aspect-fit to screen with 8px padding
                Circle()
                    .fill(DSColor.orange)
                    .frame(width: circleDiameter, height: circleDiameter)
                    // .padding(CGFloat(DSSpacing.s24))

                // Centered stopwatch time in the middle of the circle
                VStack(spacing: 0) {
                    StopwatchTimeText(viewModel.formattedTime)
                }

                // Buttons anchored to bottom-left with design system spacing
                VStack {
                    Spacer()
                    HStack(spacing: CGFloat(DSSpacing.s16)) {
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

                        Spacer()
                    }
                    .padding(.leading, CGFloat(DSSpacing.s16))
                    .padding(.bottom, CGFloat(DSSpacing.s16))
                }
            }
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

