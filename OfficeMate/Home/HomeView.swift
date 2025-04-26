//
//  HomeView.swift
//  OfficeMate
//
//  Created by 王增凤 on 26/4/2025.

// Here‘s the first home page without any setting

import SwiftUI

struct HomeView: View {
    @State private var timeOfDay: TimeOfDay = .current()
    @State private var showingSetMyDay = false
    @State private var showHome2 = false
    @State private var stretchInterval = 60
    @State private var workStartDate: Date? = nil
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    
    var body: some View {
        if showHome2, let startDate = workStartDate {
            Home2View(stretchInterval: stretchInterval, workStartDate: startDate) {
                // End workday, return to HomeView
                showHome2 = false
                workStartDate = nil
            }
        } else {
            ZStack {
                // Background image will change according time
                Image(timeOfDay.backgroundImage)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // function buttoon if needed
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
                    
                    // Welcome sign
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
                    
                    // Feature cards
                    VStack(spacing: 16) {
                        // Stretch part
                        Button(action: {}) {
                            HStack(spacing: 16) {
                                Image("IconStretch")
                                    .resizable()
                                    .frame(width: 48, height: 48)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Stretch")
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundColor(.black)
                                    Text("Move mindfully, stretch gently")
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
                        
                        //Water Part
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
                        
                        // MoodNote Part
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
                    
                    // Start button
                    Button(action: {
                        showingSetMyDay = true
                    }) {
                        Text("Start My Workday")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Color(red: 0.43, green: 0.91, blue: 0.83))
                            .cornerRadius(28)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 60)
                }
            }
            .sheet(isPresented: $showingSetMyDay) {
                SetMyDaySheet(onStart: { interval in
                    stretchInterval = interval
                    workStartDate = Date()
                    showHome2 = true
                })
            }
            .onReceive(timer) { _ in
                timeOfDay = .current()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
