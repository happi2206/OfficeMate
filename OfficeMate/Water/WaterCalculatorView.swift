//
//  WaterCalculatorView.swift
//  OfficeMate
//
//  Created on 3/5/2025.
//

import SwiftUI

struct WaterCalculatorView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var height: Double = 170
    @State private var weight: Double = 60
    @State private var gender: Gender = .female
    @State private var showingResult = false
    @State private var recommendedCups: Int = 8
    
    var onSave: (Int) -> Void
    
    enum Gender: String, CaseIterable {
        case female = "Female"
        case male = "Male"
    }
    
    var body: some View {
        ZStack {
            // Main background
            Color.white.edgesIgnoringSafeArea(.all)
            
            // Content
            VStack(alignment: .leading, spacing: 24) {
                // Back button
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .clipShape(Circle())
                }
                .padding(.top, 40)
                .padding(.leading, 20)
                
                // Title and subtitle
                VStack(alignment: .leading, spacing: 8) {
                    Text("Basic information")
                        .font(.system(size: 24, weight: .bold))
                    
                    Text("Please enter your basic info (height, weight, gender) to calculate your recommended water cups per day.")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .lineLimit(2)
                }
                .padding(.horizontal, 24)
                .padding(.top, 10)
                
                // Height slider
                VStack(alignment: .leading, spacing: 8) {
                    Text("Height (cm)")
                        .font(.system(size: 16, weight: .semibold))
                    
                    ZStack(alignment: .top) {
                        // Slider background
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.gray.opacity(0.1))
                            .frame(height: 60)
                        
                        // Slider component
                        VStack {
                            Slider(value: $height, in: 140...200, step: 1)
                                .accentColor(Color.orange)
                            
                            // Tick marks
                            HStack {
                                Text("155")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                                
                                Spacer()
                                
                                Text("160")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                                
                                Spacer()
                                
                                Text("165")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                                
                                Spacer();                               Text("170")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                                
                                Spacer()
                                
                                Text("175")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 12)
                    }
                }
                .padding(.horizontal, 24)
                
                // Weight slider
                VStack(alignment: .leading, spacing: 8) {
                    Text("Weight (kg)")
                        .font(.system(size: 16, weight: .semibold))
                    
                    ZStack(alignment: .top) {
                        // Slider background
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.gray.opacity(0.1))
                            .frame(height: 60)
                        
                        // Slider component
                        VStack {
                            Slider(value: $weight, in: 40...100, step: 1)
                                .accentColor(Color.orange)
                            
                            // Tick marks
                            HStack {
                                Text("45")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                                
                                Spacer()
                                
                                Text("50")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                                
                                Spacer();                                Text("55")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                                
                                Spacer()
                                
                                Text("60")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                                
                                Spacer();                                Text("65")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 12)
                    }
                }
                .padding(.horizontal, 24)
                
                // Gender selection
                VStack(alignment: .leading, spacing: 16) {
                    Text("Gender")
                        .font(.system(size: 16, weight: .semibold))
                    
                    HStack(spacing: 20) {
                        ForEach(Gender.allCases, id: \.self) { genderOption in
                            Button(action: {
                                gender = genderOption
                            }) {
                                VStack(spacing: 8) {
                                    ZStack {
                                        Circle()
                                            .fill(gender == genderOption ?
                                                  (genderOption == .female ? Color.yellow.opacity(0.2) : Color.purple.opacity(0.2)) :
                                                  Color.gray.opacity(0.1))
                                            .frame(width: 60, height: 60)
                                        
                                        Text(genderOption == .female ? "🤵‍♀️" : "🤵‍♂️")
                                            .font(.system(size: 30))
                                    }
                                    
                                    Text(genderOption.rawValue)
                                        .font(.system(size: 14))
                                        .foregroundColor(.black)
                                }
                            }
                            .frame(width: 120, height: 100)
                            .background(Color.white)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(gender == genderOption ?
                                            (genderOption == .female ? Color.yellow : Color.purple) :
                                            Color.gray.opacity(0.3), lineWidth: 2)
                            )
                        }
                    }
                    .padding(.horizontal, 24)
                }
                .padding(.horizontal, 24)
                
                Spacer()
                
                // Calculate button
                Button(action: {
                    calculateWaterIntake()
                    showingResult = true
                }) {
                    Text("Calculate")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color(red: 0.43, green: 0.91, blue: 0.83))
                        .cornerRadius(28)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
            
            // Results overlay
            if showingResult {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)
                
                VStack(spacing: 24) {
                    Text("You should drink")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(Color(red: 0.2, green: 0.3, blue: 0.3))
                    
                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        Text("\(recommendedCups)")
                            .font(.system(size: 56, weight: .bold))
                            .foregroundColor(Color(red: 0.43, green: 0.85, blue: 0.93))
                        
                        Text("cups per day")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                    }
                    
                    Text("( Each cup is 250ml )")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    
                    Button(action: {
                        onSave(recommendedCups)
                        dismiss()
                    }) {
                        Text("Set as Today's Goal")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Color(red: 0.43, green: 0.91, blue: 0.83))
                            .cornerRadius(28)
                    }
                    .padding(.top, 24)
                    
                    Button(action: {
                        showingResult = false
                    }) {
                        Text("Re-enter Information")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .underline()
                    }
                }
                .padding(32)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.1), radius: 10)
                .frame(width: 300)
                .transition(.scale)
                .animation(.spring(), value: showingResult)
            }
        }
    }
    
    // Calculate water intake based on height, weight, and gender
    // This uses a simple formula, but you can adjust based on your app's requirements
    private func calculateWaterIntake() {
        // Base calculation: ~30ml per kg of body weight
        let waterInMl: Double
        
        if gender == .female {
            // Women typically need slightly less water per kg (about 90% of men)
            waterInMl = weight * 30 * 0.9
        } else {
            waterInMl = weight * 30
        }
        
        // Height factor (taller people may need slightly more)
        let heightFactor = 1.0 + ((height - 170) / 100)
        
        // Convert to cups (250ml per cup)
        let cups = Int(round((waterInMl * heightFactor) / 250))
        
        // Ensure reasonable limits
        recommendedCups = min(max(cups, 5), 12)
    }
}

// Preview
struct WaterCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        WaterCalculatorView(onSave: { _ in })
    }
}
