//
//  StretchSuccessView.swift
//  OfficeMate
//
//  Created by 王增凤 on 25/4/2025.
//

import SwiftUI

struct StretchSuccessView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var stretchManager: StretchManager
    var onBackToHome: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Great Job!")
                .font(.system(size: 28, weight: .semibold))
                .foregroundColor(Color(red: 0.2, green: 0.33, blue: 0.27))
                .padding(.top, 76)
            
            Text("You've completed all stretches.\nKeep up the good work!")
                .font(.system(size: 18))
                .foregroundColor(.gray)
                .lineSpacing(7)
                .multilineTextAlignment(.center)
                .padding(.top, 24)
            
            Spacer()
            
            Button(action: {
                onBackToHome()
                dismiss()
            }) {
                Text("Back to Home")
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .frame(width: 200, height: 56)
                    .background(Color(red: 0.43, green: 0.91, blue: 0.83))
                    .cornerRadius(28)
            }
            .padding(.bottom, 70)
        }
        .frame(width: 332, height: 380)
        .background(
            ZStack {
                Color.white
                Image("StretchPopup_background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 332, height: 380)
                    .clipped()
            }
        )
        .cornerRadius(16)
    }
}

#Preview {
    StretchSuccessView(onBackToHome: {})
        .environmentObject(StretchManager())
}

