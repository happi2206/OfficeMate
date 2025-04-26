//
//  SetMyDaySheet.swift
//  OfficeMate
//
//  Created by 王增凤 on 25/4/2025.
//

import SwiftUI

struct SetMyDaySheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var stretchInterval: Int = 60
    var onStart: (Int) -> Void
    
    var body: some View {
        ZStack {
            // 主要内容
            VStack(spacing: 0) {
                // 标题部分
                VStack(alignment: .leading, spacing: 8) {
                    Text("Set My Day")
                        .font(.system(size: 24, weight: .semibold))
                    Text("Prepare for a balanced and mindful day")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                .padding(.top, 248)
                .padding(.horizontal, 24)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: 16) {
                    // 拉伸间隔设置
                    StretchIntervalCard(value: $stretchInterval)
                    
                    // 喝水目标占位
                    Rectangle()
                        .fill(Color.white)
                        .frame(height: 80)
                        .cornerRadius(16)
                        .padding(.horizontal, 24)
                    
                    // 心情选择占位
                    Rectangle()
                        .fill(Color.white)
                        .frame(height: 80)
                        .cornerRadius(16)
                        .padding(.horizontal, 24)
                }
                .padding(.top, 32)
                
                Spacer()
                
                // 开始按钮
                Button(action: {
                    onStart(stretchInterval)  // 调用回调，传递时间
                    dismiss()  // 关闭 sheet
                }) {
                    Text("Start")
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
            
            // 关闭按钮
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 20))
                            .foregroundColor(.black.opacity(0.5))
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 80)
                Spacer()
            }
            .ignoresSafeArea()
        }
        .background(Color(red: 0.96, green: 0.96, blue: 0.96))
    }
}

// 拉伸间隔设置卡片
struct StretchIntervalCard: View {
    @Binding var value: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Stretch Interval")
                .font(.system(size: 18, weight: .semibold))
            Text("Stretching every hour is recommended")
                .font(.system(size: 12))
                .foregroundColor(.gray)
                .lineLimit(1)
            
            HStack(spacing: 24) {
                Button(action: {
                    if value > 15 { value -= 15 }
                }) {
                    Image(systemName: "minus")
                        .foregroundColor(.black)
                        .frame(width: 32, height: 32)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(16)
                }
                
                Text("\(value)min")
                    .font(.system(size: 18, weight: .semibold))
                    .frame(minWidth: 60)
                
                Button(action: {
                    if value < 120 { value += 15 }
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.black)
                        .frame(width: 32, height: 32)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(16)
                }
            }
            .padding(.top, 8)
        }
        .padding(.vertical, 16)
        .padding(.leading, 116)
        .frame(width: 360, height: 120)  // 直接写死尺寸
        .background(
            ZStack {
                Color.white
                Image("StretchBackground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        )
        .cornerRadius(16)
    }
}

// 预览
struct SetMyDaySheet_Previews: PreviewProvider {
    static var previews: some View {
        SetMyDaySheet(onStart: { _ in })
    }
}

