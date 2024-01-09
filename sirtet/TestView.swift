import SwiftUI

struct TimerView: View {
    @State private var timer: Timer? = nil
    @State private var elapsedTime: TimeInterval = 0.0
    
    var body: some View {
        VStack {
            Text(String(format: "%.2f seconds", elapsedTime))
            
            HStack {
                Button("Start Timer") {
                    self.startTimer()
                }
                Button("Stop Timer") {
                    self.stopTimer()
                }
            }
        }
        .padding()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.elapsedTime += 1.0
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
