//  HomeView.swift
//  OfficeMate
//
//  Created by 王增凤 on 26/4/2025.

import SwiftUI

struct HomeView: View {
    @State private var timeOfDay: TimeOfDay = .current()
    @StateObject private var stretchManager = StretchManager()
    @State private var showingStretchSettings = false
    @State private var showingStretchSequence = false
    @State private var openMoodScreen = false
    @State private var showingStretchEntry = false
    @State private var showWaterGoalSheet = false
    @State private var userWaterGoal: Int = UserDefaults.standard.integer(forKey: "waterGoal")
    @State private var userWaterDrunk: Int = UserDefaults.standard.integer(forKey: "waterDrunk")
    @State private var lastWaterUpdateDate: Date = UserDefaults.standard.object(forKey: "lastWaterUpdateDate") as? Date ?? Date()
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()

    func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }

    var body: some View {
        ZStack {
            Image(timeOfDay.backgroundImage)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 0) {
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

                VStack(spacing: 16) {
                    Button(action: {
                        showingStretchSettings = true
                    }) {
                        HStack(spacing: 16) {
                            Image("IconStretch")
                                .resizable()
                                .frame(width: 48, height: 48)
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Stretch")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(.black)
                                if !stretchManager.isTimerActive {
                                    if stretchManager.isFirstTime {
                                        Text("Move mindfully, stretch gently")
                                            .font(.system(size: 14))
                                            .foregroundColor(.black.opacity(0.6))
                                    } else {
                                        Text("\(stretchManager.completedSessions) stretched")
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(Color(red: 0.53, green: 0.71, blue: 0.36))
                                    }
                                }
                            }
                            Spacer()
                            if stretchManager.isTimerActive, let remainingSec = stretchManager.remainingSeconds {
                                let minutes = remainingSec / 60
                                let seconds = remainingSec % 60
                                VStack(alignment: .trailing, spacing: 4) {
                                    Text("Stretch in")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color(red: 0.38, green: 0.44, blue: 0.32))
                                    Text(String(format: "%02d:%02d", minutes, seconds))
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundColor(Color(red: 0.38, green: 0.44, blue: 0.32))
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal, 20)
                                .background(Color(red: 0.95, green: 0.99, blue: 0.93))
                                .cornerRadius(20)
                            }
                        }
                        .padding(20)
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 2)
                    }

                    Button(action: {
                        showWaterGoalSheet = true
                    }) {
                        HStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(Color(red: 0.85, green: 0.95, blue: 0.98))
                                    .frame(width: 48, height: 48)
                                Image("IconWater")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 48, height: 48)
                            }
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Water")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.black)
                                if userWaterGoal == 0 {
                                    Text("Keep your body hydrated")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color.gray)
                                } else {
                                    Text("\(userWaterDrunk) / \(userWaterGoal) cups")
                                        .font(.system(size: 18))
                                        .foregroundColor(.blue)
                                }
                            }
                            Spacer()
                            if userWaterGoal > 0 {
                                if userWaterDrunk >= userWaterGoal {
                                    HStack(spacing: 8) {
                                        Image(systemName: "hand.thumbsup.fill")
                                            .font(.system(size: 20))
                                            .foregroundColor(.orange)
                                        Text("You have hit the goal!")
                                            .font(.system(size: 16))
                                            .foregroundColor(.orange)
                                            .multilineTextAlignment(.leading)
                                    }
                                } else {
                                    Button(action: {
                                        userWaterDrunk += 1
                                        UserDefaults.standard.set(userWaterDrunk, forKey: "waterDrunk")
                                    }) {
                                        Text("+ Drank One")
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 8)
                                            .background(Color(red: 0.43, green: 0.91, blue: 0.83))
                                            .cornerRadius(16)
                                    }
                                }
                            }
                        }
                        .padding(16)
                        .frame(height: 80)
                        .background(userWaterGoal > 0 && userWaterDrunk >= userWaterGoal ? Color(red: 1.0, green: 0.98, blue: 0.9) : Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(userWaterGoal > 0 && userWaterDrunk == 0 ? Color.blue : Color.clear, lineWidth: 2)
                        )
                        .cornerRadius(16)
                    }
                    .sheet(isPresented: $showWaterGoalSheet) {
                        WaterGoalSheet(onSave: { cups in
                            userWaterGoal = cups
                            UserDefaults.standard.set(cups, forKey: "waterGoal")
                            if !isSameDay(date1: lastWaterUpdateDate, date2: Date()) {
                                userWaterDrunk = 0
                                UserDefaults.standard.set(userWaterDrunk, forKey: "waterDrunk")
                            }
                            lastWaterUpdateDate = Date()
                            UserDefaults.standard.set(lastWaterUpdateDate, forKey: "lastWaterUpdateDate")
                        })
                    }

                    
                    Button(action: { openMoodScreen = true}) {
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
            }

            if showingStretchEntry {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .overlay {
                        StretchEntryView(isPresented: $showingStretchEntry, onStart: {
                            showingStretchEntry = false
                            showingStretchSequence = true
                        })
                        .environmentObject(stretchManager)
                    }
            }
        }
        .sheet(isPresented: $showingStretchSettings) {
            StretchSettingsView(onStart: {
                showingStretchSettings = false
                showingStretchSequence = true
            })
            .environmentObject(stretchManager)
        }
        
        .sheet(isPresented: $openMoodScreen) {
                     MoodViewSheet { mood, thought, note in
                         // Handle mood logging
                         print(mood?.label ?? "No mood")
                         print(thought)
                         print(note)
                     }
                 }
        
        
        .fullScreenCover(isPresented: $showingStretchSequence) {
            StretchSequenceView()
                .environmentObject(stretchManager)
        }
        .onReceive(timer) { _ in
            timeOfDay = .current()
        }
        .onChange(of: stretchManager.isTimerActive) { isActive in
            if !isActive {
                showingStretchEntry = true
            }
        }
        .onAppear {
            if !isSameDay(date1: lastWaterUpdateDate, date2: Date()) {
                userWaterDrunk = 0
                UserDefaults.standard.set(userWaterDrunk, forKey: "waterDrunk")
                lastWaterUpdateDate = Date()
                UserDefaults.standard.set(lastWaterUpdateDate, forKey: "lastWaterUpdateDate")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

