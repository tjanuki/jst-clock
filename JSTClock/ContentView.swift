import SwiftUI
import Foundation
import ServiceManagement

@main
struct JSTClockApp: App {
    @State private var currentTime = ""
    @State private var isLoginItem = false
    
    var body: some Scene {
        MenuBarExtra(currentTime, systemImage: "clock") {
            VStack(alignment: .leading, spacing: 10) {
                Text("Japan Standard Time")
                    .font(.headline)
                
                Text(currentTime)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Divider()
                
                Toggle("Start at Login", isOn: $isLoginItem)
                    .onChange(of: isLoginItem) { newValue in
                        setLoginItem(enabled: newValue)
                    }
                
                Divider()
                
                Button("Quit") {
                    NSApplication.shared.terminate(nil)
                }
                .keyboardShortcut("q")
            }
            .padding()
        }
        .onAppear {
            updateTime()
            startTimer()
            checkLoginItemStatus()
        }
    }
    
    private func updateTime() {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        formatter.dateFormat = "MMM dd HH:mm"
        currentTime = formatter.string(from: Date())
    }
    
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            updateTime()
        }
    }
    
    private func setLoginItem(enabled: Bool) {
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
}
