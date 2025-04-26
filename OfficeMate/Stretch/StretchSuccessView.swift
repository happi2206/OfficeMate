//
//  StretchSuccessView.swift
//  OfficeMate
//
//  Created by 王增凤 on 25/4/2025.
//

import SwiftUI

struct StretchSuccessView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Color.black.opacity(0.4)  // 添加半透明黑色背景
            .ignoresSafeArea()
            .overlay {
                VStack(spacing: 0) {
                    Text("Great Job !")  // 注意感叹号前有空格
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(Color(red: 0.2, green: 0.33, blue: 0.27))
                        .padding(.top, 76)
                    
                    Text("You've completed all your\nstretches.")  // 分两行显示
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .lineSpacing(7)
                        .padding(.top, 24)
                    
                    Text("Remember to drink some water!")  // 添加新的提示文字
                        .font(.system(size: 14))
                        .foregroundColor(Color(red: 0.43, green: 0.91, blue: 0.83))  // 使用主题色
                        .multilineTextAlignment(.center)
                        .lineSpacing(7)
                        .padding(.top, 16)
                    
                    Spacer()
                    
                    // 只保留一个按钮
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Back to Home")
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                            .frame(width: 200, height: 56)  // 宽度改为 200
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
}

#Preview {
    StretchSuccessView()
}

