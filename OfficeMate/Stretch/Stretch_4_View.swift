//
//  Stretch_4_View.swift
//  OfficeMate
//
//  Created by 王增凤 on 25/4/2025.
//

import SwiftUI
import UIKit

struct Stretch_4_View: View {
    @State private var timeRemaining: Int = 15
    @State private var progress: CGFloat = 1.0
    @State private var navigateToStretch5: Bool = false
    @State private var showFailedView: Bool = false
    @Environment(\.dismiss) private var dismiss
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var isTimerPaused: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    
                    ZStack {
                        HStack {
                            Button(action: {
                                showFailedView = true
                            }) {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                            }
                            .padding(.leading)
                            Spacer()
                        }
                        
                        Text("4/6")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 6)
                            .background(Color(red: 0.85, green: 0.99, blue: 0.97))
                            .cornerRadius(16)
                    }
                    .padding(.top, 16)
                    
                 
                    Text("Arm Raise Cheer")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(Color(red: 0.2, green: 0.33, blue: 0.27))
                        .padding(.top, 40)
                    
                    
                    GIFImage(name: "arm_raise_cheer")
                        .frame(width: 262, height: 325)
                        .padding(.top, 60)
                    
                    Spacer()
                    
                    
                    Text("Raise your arms joyfully, \n then bring them back. Repeat slowly.")
                        .font(.system(size: 16))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.47, green: 0.47, blue: 0.47))
                        .padding(.bottom, 40)
                    
                   
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
                    
                   
                    Button(action: {
                        navigateToStretch5 = true
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
                
                if showFailedView {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .overlay {
                            StretchFailedView(isPresented: $showFailedView, onResume: {
                                isTimerPaused = false
                            })
                        }
                        .onAppear {
                            isTimerPaused = true
                        }
                }
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden()
            .onReceive(timer) { _ in
                if !isTimerPaused {
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                        withAnimation(.linear(duration: 1)) {
                            progress = CGFloat(timeRemaining) / 15.0
                        }
                    } else {
                        navigateToStretch5 = true
                    }
                }
            }
            .navigationDestination(isPresented: $navigateToStretch5) {
                Stretch_5_View()
            }
            .onAppear {
                timeRemaining = 15
                progress = 1.0
            }
        }
    }
}

#Preview {
    Stretch_4_View()
}


