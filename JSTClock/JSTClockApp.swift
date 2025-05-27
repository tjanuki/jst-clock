import SwiftUI
import Foundation
import ServiceManagement

@main
struct JSTClockApp: App {
    @StateObject private var clockManager = ClockManager()
    
    var body: some Scene {
        MenuBarExtra(clockManager.currentTime, systemImage: "clock") {
            VStack(alignment: .leading, spacing: 10) {
                Text("Japan Standard Time")
                    .font(.headline)
                
                Text(clockManager.currentTime)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Divider()
                
                Toggle("Start at Login", isOn: $clockManager.isLoginItem)
                    .onChange(of: clockManager.isLoginItem) { newValue in
                        clockManager.setLoginItem(enabled: newValue)
                    }
                
                Divider()
                
                Button("Quit") {
                    NSApplication.shared.terminate(nil)
                }
                .keyboardShortcut("q")
            }
            .padding()
        }
    }
}

class ClockManager: ObservableObject {
    @Published var currentTime = ""
    @Published var isLoginItem = false
    
    private var timer: Timer?
    
    init() {
        updateTime()
        startTimer()
        checkLoginItemStatus()
    }
    
    private func updateTime() {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        formatter.dateFormat = "MMM dd HH:mm"
        currentTime = formatter.string(from: Date())
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateTime()
        }
    }
    
    func setLoginItem(enabled: Bool) {
        if #available(macOS 13.0, *) {
            do {
                if enabled {
                    try SMAppService.mainApp.register()
                } else {
                    try SMAppService.mainApp.unregister()
                }
            } catch {
                print("Failed to \(enabled ? "enable" : "disable") login item: \(error)")
            }
        }
    }
    
    private func checkLoginItemStatus() {
        if #available(macOS 13.0, *) {
            isLoginItem = SMAppService.mainApp.status == .enabled
        }
    }
    
    deinit {
        timer?.invalidate()
    }
}
