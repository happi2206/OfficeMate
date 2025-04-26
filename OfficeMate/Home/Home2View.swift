//
//  Home2View.swift
//  OfficeMate
//
//  Created by 王增凤 on 26/4/2025.
//
// Home page changes after SetMyDay


import SwiftUI

struct Home2View: View {
    let stretchInterval: Int
    let workStartDate: Date
    let onEnd: () -> Void

    @State private var workingSeconds: Int = 0
    @State private var remainingTime: Int
    @State private var timeOfDay: TimeOfDay = .current()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var showingStretchEntry = false
    
    init(stretchInterval: Int, workStartDate: Date, onEnd: @escaping () -> Void) {
        self.stretchInterval = stretchInterval
        self.workStartDate = workStartDate
        self.onEnd = onEnd
        _remainingTime = State(initialValue: stretchInterval * 60)
    }

    var body: some View {
        ZStack {
            // background image
            Image(timeOfDay.backgroundImage)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // funtiom button if need
                HStack {
                    Spacer()
                    HStack(spacing: 12) {
                        Button(action: {}) {
                            Image(systemName: "gearshape")
                                .font(.system(size: 20))
                                .foregroundColor(.black.opacity(0.5))
                        }
                        .frame(width: 44, height: 44)
                        .background(Color.white.opacity(0.3))
                        .cornerRadius(12)
                        
                        Button(action: {}) {
                            Image(systemName: "chart.bar")
                                .font(.system(size: 20))
                                .foregroundColor(.black.opacity(0.5))
                        }
                        .frame(width: 44, height: 44)
                        .background(Color.white.opacity(0.3))
                        .cornerRadius(12)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 80)
                
                // 欢迎区域
                VStack(alignment: .leading, spacing: 8) {
                    Text("Hi, Wonder")
                        .font(.system(size: 28, weight: .semibold))
                    Text(timeOfDay.greeting)
                        .font(.system(size: 16))
                        .foregroundColor(.black.opacity(0.6))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.top, 180)
                
                // Feature card area
                VStack(spacing: 16) {
                    // Stretch card changes after Set My Day
                    Button(action: {}) {
                        HStack(spacing: 16) {
                            Image("IconStretch")
                                .resizable()
                                .frame(width: 48, height: 48)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Stretch")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.black)
                                Text("Next Stretch in：\(formatTime(remainingTime))")
                                    .font(.system(size: 14))
                                    .foregroundColor(.black.opacity(0.6))
                            }
                            
                            Spacer()
                            
                            Color.clear.frame(width: 24, height: 24)
                        }
                        .padding(16)
                        .frame(height: 80)
                        .background(Color.white)
                        .cornerRadius(16)
                    }
                    
                    // Water Part
                    Button(action: {}) {
                        HStack(spacing: 16) {
                            Image("IconWater")
                                .resizable()
                                .frame(width: 48, height: 48)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Water")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.black)
                                Text("Keep your body hydrated")
                                    .font(.system(size: 14))
                                    .foregroundColor(.black.opacity(0.6))
                            }
                            
                            Spacer()
                            
                            Color.clear.frame(width: 24, height: 24)
                        }
                        .padding(16)
                        .frame(height: 80)
                        .background(Color.white)
                        .cornerRadius(16)
                    }
                    
                    // MoodNoteCard Part
                    Button(action: {}) {
                        HStack(spacing: 16) {
                            Image("IconMoodNote")
                                .resizable()
                                .frame(width: 48, height: 48)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("MoodNote")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.black)
                                Text("One emoji, one feeling, one thought")
                                    .font(.system(size: 14))
                                    .foregroundColor(.black.opacity(0.6))
                            }
                            
                            Spacer()
                            
                            Color.clear.frame(width: 24, height: 24)
                        }
                        .padding(16)
                        .frame(height: 80)
                        .background(Color.white)
                        .cornerRadius(16)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 32)
                
                Spacer()

                VStack(spacing: 8) {
                    Button(action: {
                        onEnd()
                    }) {
                        Text("End My Workday")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Color(red: 1, green: 0.85, blue: 0.7))
                            .cornerRadius(28)
                    }

                    Text("You have been working for \(formattedWorkingTime)")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 60)
            }
        }
        .onAppear {
            // Initialize workingSeconds
            workingSeconds = Int(Date().timeIntervalSince(workStartDate))
        }
        .onReceive(timer) { _ in
            if remainingTime > 0 {
                remainingTime -= 1
            } else if !showingStretchEntry {
                showingStretchEntry = true
            }
        }
        .sheet(isPresented: $showingStretchEntry) {
            StretchEntryView(onStart: {
                remainingTime = stretchInterval * 60
                showingStretchEntry = false
            })
        }
    }

    var formattedWorkingTime: String {
        let hours = workingSeconds / 3600
        let minutes = (workingSeconds % 3600) / 60
        return "\(hours)h \(minutes)m"
    }

    func formatTime(_ seconds: Int) -> String {
        let m = seconds / 60
        let s = seconds % 60
        return String(format: "%02d:%02d", m, s)
    }
}

#Preview {
    Home2View(stretchInterval: 60, workStartDate: Date(), onEnd: {})
}
