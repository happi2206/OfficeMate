import Foundation
import SwiftUI
import Combine

class StretchViewModel: ObservableObject {
    @Published var currentExerciseIndex: Int = 0
    @Published var timeRemaining: Int = 15
    @Published var progress: CGFloat = 1.0
    @Published var isTimerPaused: Bool = false
    @Published var showFailedView: Bool = false
    @Published var navigateToNext: Bool = false
    
    private var timer: AnyCancellable?
    private let exercises = StretchExercise.exercises
    
    var currentExercise: StretchExercise {
        exercises[currentExerciseIndex]
    }
    
    var isLastExercise: Bool {
        currentExerciseIndex == exercises.count - 1
    }
    
    init() {
        setupTimer()
        resetTimer()
    }
    
    private func setupTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateTimer()
            }
    }
    
    private func updateTimer() {
        guard !isTimerPaused else { return }
        
        if timeRemaining > 0 {
            timeRemaining -= 1
            withAnimation(.linear(duration: 1)) {
                progress = CGFloat(timeRemaining) / CGFloat(currentExercise.duration)
            }
        } else {
            if isLastExercise {
                // 完成所有练习
                navigateToNext = true
            } else {
                // 进入下一个练习
                moveToNextExercise()
            }
        }
    }
    
    func moveToNextExercise() {
        if currentExerciseIndex < exercises.count - 1 {
            currentExerciseIndex += 1
            resetTimer()
        }
    }
    
    func resetTimer() {
        timeRemaining = currentExercise.duration
        progress = 1.0
    }
    
    func pauseTimer() {
        isTimerPaused = true
    }
    
    func resumeTimer() {
        isTimerPaused = false
    }
    
    func skipExercise() {
        navigateToNext = true
    }
} 