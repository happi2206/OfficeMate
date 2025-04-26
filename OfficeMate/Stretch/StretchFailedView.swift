//
//  StretchFailedView.swift
//  OfficeMate
//
//  Created by 王增凤 on 25/4/2025.
//

import SwiftUI

struct StretchFailedView: View {
    @Binding var isPresented: Bool
    var onResume: (() -> Void)? = nil
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Leave the session?")
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(Color(red: 0.2, green: 0.33, blue: 0.27))
                .padding(.top, 76)
            
            Text("You haven't finished all steps yet. \n Are you sure you want to exit?")
                .font(.system(size: 18
                             ))
                .foregroundColor(.gray)
                .lineSpacing(7)
                .multilineTextAlignment(.center)
                .padding(.top, 24)
            
            Spacer()
            
            HStack(spacing: 16) {
                Button(action: {
                    isPresented = false
                    dismiss()
                }) {
                    Text("Give up")
                        .font(.system(size: 18))
                        .foregroundColor(Color(red: 0.47, green: 0.47, blue: 0.47))
                        .frame(width: 120, height: 56)
                        .overlay(
                            RoundedRectangle(cornerRadius: 28)
                                .stroke(Color(red: 0.93, green: 0.93, blue: 0.93), lineWidth: 1)
                        )
                }
                
                Button(action: {
                    isPresented = false
                    onResume?()
                }) {
                    Text("Continue")
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                        .frame(width: 120, height: 56)
                        .background(Color(red: 0.43, green: 0.91, blue: 0.83))
                        .cornerRadius(28)
                }
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
    StretchFailedView(isPresented: .constant(true))
}

