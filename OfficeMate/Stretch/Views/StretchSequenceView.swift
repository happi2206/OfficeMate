import SwiftUI

// 拉伸动作数据模型
struct StretchAction {
    let title: String
    let description: String
    let gifName: String
}

struct StretchSequenceView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var stretchManager: StretchManager
    @State private var timeRemaining: Int = 15
    @State private var progress: CGFloat = 1.0
    @State private var showingFailedView = false
    @State private var isTimerPaused: Bool = false
    @State private var showingSuccessView = false
    // Countdown state
    @State private var showingCountdown = true
    @State private var countdownValue = 3
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // 所有拉伸动作数据
    let stretchActions: [StretchAction] = [
        StretchAction(
            title: "Head Side to Side",
            description: "Gently turn your head to the left,\nthen to the right. Repeat slowly.",
            gifName: "clean_single_nod_animation"
        ),
        StretchAction(
            title: "Look Around",
            description: "Turn your head left,\nthen right. Repeat slowly.",
            gifName: "look_around_animation"
        ),
        StretchAction(
            title: "Head Up and Down",
            description: "Look up,\nthen down. Repeat slowly.",
            gifName: "shoulder_drop_stretch_slow"
        ),
        StretchAction(
            title: "Arm Raise Cheer",
            description: "Raise your arms joyfully,\nthen bring them back. Repeat slowly.",
            gifName: "arm_raise_cheer"
        ),
        StretchAction(
            title: "Arm Raise Stretch",
            description: "Lift arms from side to high,\nthen lower. Repeat gently.",
            gifName: "arm_raise_stretch"
        ),
        StretchAction(
            title: "Side Bend Stretch",
            description: "Bend gently to one side,\nthen the other. Repeat slowly.",
            gifName: "side_bend_stretch"
        )
    ]
    
    var currentStretch: StretchAction {
        let index = stretchManager.currentStretchIndex
        print("Current stretch index: \(index)")
        let action = stretchActions[index]
        print("Current stretch title: \(action.title)")
        print("Current stretch GIF: \(action.gifName)")
        return action
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Countdown overlay
                if showingCountdown {
                    Color(red: 0.43, green: 0.91, blue: 0.83)
                        .ignoresSafeArea()
                        .zIndex(2)
                    Text(countdownValue > 0 ? "\(countdownValue)" : "Go!")
                        .font(.system(size: 100, weight: .bold))
                        .foregroundColor(.white)
                        .transition(.scale.combined(with: .opacity))
                        .zIndex(3)
                }
                VStack(spacing: 0) {
                    // 导航栏
                    ZStack {
                        HStack {
                            Button(action: {
                                showingFailedView = true
                            }) {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                            }
                            .padding(.leading)
                            Spacer()
                        }
                        Text("\(stretchManager.currentStretchIndex + 1)/\(stretchManager.totalStretches)")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 6)
                            .background(Color(red: 0.85, green: 0.99, blue: 0.97))
                            .cornerRadius(16)
                    }
                    .padding(.top, 16)
                    
                    // 标题
                    Text(currentStretch.title)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(Color(red: 0.2, green: 0.33, blue: 0.27))
                        .padding(.top, 40)
                    
                    // GIF 图片
                    GIFImage(name: currentStretch.gifName)
                        .frame(width: 262, height: 325)
                        .padding(.top, 60)
                        .id(currentStretch.gifName)
                    
                    Spacer()
                    
                    // 描述
                    Text(currentStretch.description)
                        .font(.system(size: 16))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.47, green: 0.47, blue: 0.47))
                        .padding(.bottom, 40)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    // 倒计时
                    VStack(spacing: 6) {
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 7)
                                .fill(Color(red: 0.93, green: 0.93, blue: 0.93))
                                .frame(width: 240, height: 14)
                            RoundedRectangle(cornerRadius: 7)
                                .fill(Color(red: 0.43, green: 0.91, blue: 0.83))
                                .frame(width: 240 * progress, height: 14)
                        }
                        Text("\(timeRemaining)s")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(Color(red: 0.2, green: 0.33, blue: 0.27))
                    }
                    
                    // 跳过按钮
                    Button(action: {
                        print("Skip button pressed, current index: \(stretchManager.currentStretchIndex)")
                        if stretchManager.currentStretchIndex < stretchManager.totalStretches - 1 {
                            stretchManager.nextStretch()
                            print("Moving to next stretch, new index: \(stretchManager.currentStretchIndex)")
                            resetTimer()
                        } else {
                            showingFailedView = true
                        }
                    }) {
                        Text("Skip")
                            .font(.system(size: 16))
                            .foregroundColor(Color(red: 0.47, green: 0.47, blue: 0.47))
                            .frame(width: 120, height: 44)
                            .overlay(
                                RoundedRectangle(cornerRadius: 22)
                                    .stroke(Color(red: 0.93, green: 0.93, blue: 0.93), lineWidth: 1)
                            )
                    }
                    .padding(.top, 40)
                    .padding(.bottom, 34)
                }
                .background(Color.white)
                
                if showingFailedView {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .overlay {
                            StretchFailedView(isPresented: $showingFailedView, onResume: {
                                isTimerPaused = false
                            })
                        }
                        .onAppear {
                            isTimerPaused = true
                        }
                }
                
                if showingSuccessView {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .overlay {
                            StretchSuccessView(onBackToHome: {
                                stretchManager.incrementCompletedSessions()
                                dismiss()
                            })
                        }
                }
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden()
        }
        .onReceive(timer) { _ in
            if !isTimerPaused && !showingCountdown {
                if timeRemaining > 0 {
                    timeRemaining -= 1
                    withAnimation(.linear(duration: 1)) {
                        progress = CGFloat(timeRemaining) / 15.0
                    }
                } else {
                    if stretchManager.currentStretchIndex == stretchManager.totalStretches - 1 {
                        showingSuccessView = true
                    } else {
                        stretchManager.nextStretch()
                        resetTimer()
                    }
                }
            }
        }
        .onAppear {
            startCountdown()
            stretchManager.startStretchSequence()
            resetTimer()
        }
        .onDisappear {
            stretchManager.skipStretchSequence()
        }
    }
    
    private func resetTimer() {
        timeRemaining = 15
        progress = 1.0
    }
    
    private func startCountdown() {
        countdownValue = 3
        showingCountdown = true
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if countdownValue > 0 {
                withAnimation(.easeInOut(duration: 0.5)) {
                    countdownValue -= 1
                }
            } else {
                timer.invalidate()
                withAnimation(.easeInOut(duration: 0.5)) {
                    showingCountdown = false
                }
            }
        }
    }
}

#Preview {
    StretchSequenceView()
        .environmentObject(StretchManager())
} 

