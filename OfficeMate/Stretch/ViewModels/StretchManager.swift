import SwiftUI
import Combine

class StretchManager: ObservableObject {
    @Published var remainingMinutes: Int?
    @Published var remainingSeconds: Int?
    @Published var completedSessions: Int = 0
    @Published var isTimerActive: Bool = false
    @Published var currentStretchIndex: Int = 0
    @Published var isStretchSequenceActive: Bool = false
    @Published var isFirstTime: Bool = true
    
    private var timer: AnyCancellable?
    
    let totalStretches = 6
    
    init() {
        // Load completed sessions from UserDefaults
        completedSessions = UserDefaults.standard.integer(forKey: "completedSessions")
        
        // Check if it's first time
        // 如果 UserDefaults 中没有 isFirstTime 的值，说明是第一次启动
        if UserDefaults.standard.object(forKey: "isFirstTime") == nil {
            isFirstTime = true
            UserDefaults.standard.set(true, forKey: "isFirstTime")
        } else {
            isFirstTime = UserDefaults.standard.bool(forKey: "isFirstTime")
        }
    }
    
    func startTimer(minutes: Int) {
        remainingMinutes = minutes
        if minutes == 1 {
            remainingSeconds = 5 // 测试用，1min选项实际为5秒
        } else {
            remainingSeconds = minutes * 60
        }
        isTimerActive = true
        
        timer?.cancel()
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if let seconds = self.remainingSeconds {
                    if seconds > 0 {
                        self.remainingSeconds = seconds - 1
                        self.remainingMinutes = self.remainingSeconds! / 60
                    } else {
                        self.stopTimer()
                        // 当计时器结束时，显示拉伸入口
                        self.isStretchSequenceActive = true
                    }
                }
            }
    }
    
    func stopTimer() {
        timer?.cancel()
        timer = nil
        remainingMinutes = nil
        remainingSeconds = nil
        isTimerActive = false
    }
    
    func incrementCompletedSessions() {
        completedSessions += 1
        UserDefaults.standard.set(completedSessions, forKey: "completedSessions")
    }
    
    func startStretchSequence() {
        currentStretchIndex = 0
        isStretchSequenceActive = true
    }
    
    func nextStretch() {
        if currentStretchIndex < totalStretches - 1 {
            currentStretchIndex += 1
            print("Moving to next stretch, current index: \(currentStretchIndex)")
        } else {
            completeStretchSequence()
        }
    }
    
    func completeStretchSequence() {
        isStretchSequenceActive = false
        currentStretchIndex = 0
        incrementCompletedSessions()
        
        // 只有在完成第一次拉伸时才将 isFirstTime 设为 false
        if isFirstTime {
            isFirstTime = false
            UserDefaults.standard.set(false, forKey: "isFirstTime")
        }
        
        print("Completed stretch sequence")
    }
    
    func skipStretchSequence() {
        isStretchSequenceActive = false
        currentStretchIndex = 0
        print("Skipped stretch sequence")
    }
} 