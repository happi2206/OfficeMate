import SwiftUI

struct StretchSettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var stretchManager: StretchManager
    @State private var selectedMinutes: Int = 30
    
    let minutesOptions = [1, 15, 30, 45, 60]
    var onStart: () -> Void
    
    var body: some View {
        ZStack {
            // Background
            Color.white
            Image("StretchPopup_background")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .opacity(0.3)
            
            // Content
            VStack(spacing: 32) {
                // Header with close button
                HStack {
                    Spacer()
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 24)
                
                Spacer()
                
                // Title and Description
                VStack(spacing: 16) {
                    Text("Stretch Settings")
                        .font(.system(size: 32, weight: .semibold))
                        .foregroundColor(Color(red: 0.2, green: 0.33, blue: 0.27))
                    
                    Text("Choose when to start your stretch session")
                        .font(.system(size: 18, weight: .regular))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                }
                
                // Timer Selection
                VStack(spacing: 20) {
                    Text("Set Reminder")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                    
                    HStack(spacing: 16) {
                        ForEach(minutesOptions, id: \.self) { minutes in
                            Button(action: {
                                selectedMinutes = minutes
                            }) {
                                Text("\(minutes)min")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(selectedMinutes == minutes ? .white : Color(red: 0.6, green: 0.6, blue: 0.6))
                                    .frame(width: 70, height: 44)
                                    .background(
                                        selectedMinutes == minutes ?
                                        Color(red: 0.43, green: 0.91, blue: 0.83) :
                                        Color(red: 0.95, green: 0.95, blue: 0.95)
                                    )
                                    .cornerRadius(22)
                            }
                        }
                    }
                }
                .padding(.vertical, 20)
                
                Spacer()
                
                // Buttons
                VStack(spacing: 24) {
                    // 倒计时提示
                    if stretchManager.isTimerActive, let remainingSec = stretchManager.remainingSeconds {
                        let minutes = remainingSec / 60
                        let seconds = remainingSec % 60
                        Text("You will stretch in \(String(format: "%02d:%02d", minutes, seconds))")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color(red: 0.8, green: 0.6, blue: 0.2))
                    }
                    // Set Timer Button
                    Button(action: {
                        stretchManager.startTimer(minutes: selectedMinutes)
                        dismiss()
                    }) {
                        Text(stretchManager.isTimerActive ? "Reset Timer in \(selectedMinutes)min" : "Set \(selectedMinutes)min Timer")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(
                                stretchManager.isTimerActive
                                    ? Color(red: 1, green: 0.6, blue: 0.2)
                                    : Color(red: 0.43, green: 0.91, blue: 0.83)
                            )
                            .cornerRadius(28)
                    }
                    .padding(.horizontal, 24)
                    
                    // Divider
                    HStack {
                        VStack { Divider() }.padding(.horizontal, 24)
                        Text("or")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        VStack { Divider() }.padding(.horizontal, 24)
                    }
                    
                    // Start Now Button
                    Button(action: {
                        stretchManager.incrementCompletedSessions()
                        onStart()
                        dismiss()
                    }) {
                        Text("Start Now")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Color(red: 0.2, green: 0.33, blue: 0.27))
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 28)
                                    .stroke(Color(red: 0.2, green: 0.33, blue: 0.27), lineWidth: 1)
                            )
                    }
                    .padding(.horizontal, 24)
                }
                .padding(.bottom, 40)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    StretchSettingsView(onStart: {})
        .environmentObject(StretchManager())
} 