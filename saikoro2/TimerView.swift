import SwiftUI

struct TimerView: View {
    @State private var minutes = 5
    @State private var seconds = 0
    @State private var timer: Timer?
    @State private var isTimerRunning = false

    var body: some View {
        VStack {
            Text("\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))")
                .font(.largeTitle)
                .padding()

            Stepper(value: $minutes, in: 1...60) {
                Text("Minutes: \(minutes)")
            }
            .padding()

            HStack {
                Button(action: {
                    startStopTimer()
                }) {
                    Text(isTimerRunning ? "Stop" : "Start")
                        .padding()
                        .foregroundColor(isTimerRunning ? Color.red : Color.blue)
//                        .background(isTimerRunning ? Color.red : Color.blue)
                        .cornerRadius(10)
                }
//                .padding()

                Button(action: {
                    resetTimer()
                }) {
                    Text("Reset")
                        .padding()
                        .foregroundColor(.gray)
                        .cornerRadius(10)
                }
//                .padding()
            }
        }
    }

    private func startStopTimer() {
        if isTimerRunning {
            stopTimer()
        } else {
            startTimer()
        }
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if seconds > 0 {
                seconds -= 1
            } else if minutes > 0 {
                minutes -= 1
                seconds = 59
            } else {
                stopTimer()
            }
        }
        isTimerRunning = true
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        isTimerRunning = false
    }

    private func resetTimer() {
        stopTimer()
        minutes = 5
        seconds = 0
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
