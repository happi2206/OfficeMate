//
//  WaterGoalSheet.swift
//  OfficeMate
//
//  Created on 3/5/2025.
//

//
//  WaterGoalSheet.swift
//  OfficeMate
//
//  Created on 3/5/2025.
//

import SwiftUI

struct WaterGoalSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var waterCups: Int = 8
    @State private var showCalculator: Bool = false
    var onSave: (Int) -> Void
    
    var body: some View {
        ZStack {
            // Main content
            VStack(alignment: .leading, spacing: 0) {
                // Header with background image preview
                ZStack(alignment: .bottomLeading) {
                    // Reuse afternoon background image
                    Image("HomeAfternoon")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 180)
                        .clipShape(Rectangle())
                    
                    Text("Hi, Wonder")
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 20)
                }
                
                // Sheet content
                VStack(alignment: .leading, spacing: 16) {
                    // Title
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Set My daily water goal")
                            .font(.system(size: 24, weight: .semibold))
                        Text("We suggest 6-8 cups a day")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 24)
                    .padding(.horizontal, 24)
                    
                    // Water cup selector
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                        
                        HStack(spacing: 24) {
                            // Water cup image
                            Image("IconWater") // Make sure you have this asset
                                .resizable()
                                .frame(width: 48, height: 48)
                                .padding(.leading, 16)
                            
                            // 中间控制器部分
                                    HStack(spacing: 20) {
                                        // 减号按钮
                                        Button(action: {
                                            if waterCups > 1 { waterCups -= 1 }
                                        }) {
                                            Circle()
                                                .fill(Color(white: 0.95))
                                                .frame(width: 32, height: 32)
                                                .overlay(
                                                    Image(systemName: "minus")
                                                        .font(.system(size: 16, weight: .medium))
                                                        .foregroundColor(Color(white: 0.4))
                                                )
                                        }
                                        // 杯数显示
                                        Text("\(waterCups)")
                                            .font(.system(size: 22, weight: .semibold))
                                            .foregroundColor(Color(red: 0.1, green: 0.2, blue: 0.45))
                                            .frame(minWidth: 30)
                                        // 加号按钮
                                        Button(action: {
                                            if waterCups < 16 { waterCups += 1 }
                                        }) {
                                            Circle()
                                                .fill(Color(white: 0.95))
                                                .frame(width: 32, height: 32)
                                                .overlay(
                                                    Image(systemName: "plus")
                                                        .font(.system(size: 16, weight: .medium))
                                                        .foregroundColor(Color(white: 0.4))
                                                )
                                        }
                                    }
                                    Spacer()
                            
                            // Units label
                            Text("Cups")
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                                .padding(.trailing, 16)
                        }
                        .padding(.vertical, 16)
                    }
                    .frame(height: 80)
                    .padding(.horizontal, 24)
                    .padding(.top, 24)
                    
                    // Calculate button
                    Button(action: {
                        showCalculator = true
                    }) {
                        Text("Calculate my reasonable daily drink")
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                            .underline()
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 8)
                    
                    Spacer()
                    
                    // Set button
                    Button(action: {
                        onSave(waterCups)
                        dismiss()
                    }) {
                        Text("Set")
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
                .background(Color.white)
            }
            
            // Close button at top-right
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                            .padding(8)
                            .background(Color.white.opacity(0.8))
                            .clipShape(Circle())
                    }
                    .padding(.trailing, 16)
                    .padding(.top, 16)
                }
                Spacer()
            }
        }
        .sheet(isPresented: $showCalculator) {
            WaterCalculatorView(onSave: { cups in
                waterCups = cups
                showCalculator = false
            })
        }
    }
}

// Water calculator has been moved to a separate file: WaterCalculatorView.swift

// Preview
struct WaterGoalSheet_Previews: PreviewProvider {
    static var previews: some View {
        WaterGoalSheet(onSave: { _ in })
    }
}
