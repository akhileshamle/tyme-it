import Foundation
import Combine

@MainActor
final class StopwatchViewModel: ObservableObject {
    @Published private(set) var isRunning: Bool = false
    @Published private(set) var elapsed: TimeInterval = 0

    private var startDate: Date?
    private var timerCancellable: AnyCancellable?

    // Expose a formatted string for the view
    var formattedTime: String {
        let total = Int(elapsed)
        let hours = total / 3600
        let minutes = (total % 3600) / 60
        let seconds = total % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }

    func toggle() {
        isRunning.toggle()
        if isRunning {
            start()
        } else {
            stop()
        }
    }

    func reset() {
        stop()
        elapsed = 0
        startDate = nil
    }

    private func start() {
        startDate = nil
        // Create a timer publisher ticking every 0.01s
        timerCancellable = Timer.publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] now in
                guard let self = self, self.isRunning else { return }
                if let start = self.startDate {
                    self.elapsed += now.timeIntervalSince(start)
                    self.startDate = now
                } else {
                    self.startDate = now
                }
            }
    }

    private func stop() {
        isRunning = false
        timerCancellable?.cancel()
        timerCancellable = nil
        startDate = nil
    }
}
