import SwiftUI

// 导入所需的组件
import UIKit

struct StretchExerciseView: View {
    @ObservedObject var viewModel: StretchViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    // 导航栏
                    ZStack {
                        HStack {
                            Button(action: {
                                viewModel.showFailedView = true
                            }) {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                            }
                            .padding(.leading)
                            Spacer()
                        }
                        
                        Text("\(viewModel.currentExerciseIndex + 1)/\(StretchExercise.exercises.count)")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 6)
                            .background(Color(red: 0.85, green: 0.99, blue: 0.97))
                            .cornerRadius(16)
                    }
                    .padding(.top, 16)
                    
                    // 标题
                    Text(viewModel.currentExercise.title)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(Color(red: 0.2, green: 0.33, blue: 0.27))
                        .padding(.top, 40)
                    
                    // GIF 图片
                    GIFImage(name: viewModel.currentExercise.gifName)
                        .frame(width: 262, height: 325)
                        .padding(.top, 60)
                    
                    Spacer()
                    
                    // 描述
                    Text(viewModel.currentExercise.description)
                        .font(.system(size: 16))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.47, green: 0.47, blue: 0.47))
                        .padding(.bottom, 40)
                    
                    // 倒计时
                    VStack(spacing: 6) {
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 7)
                                .fill(Color(red: 0.93, green: 0.93, blue: 0.93))
                                .frame(width: 240, height: 14)
                            
                            RoundedRectangle(cornerRadius: 7)
                                .fill(Color(red: 0.43, green: 0.91, blue: 0.83))
                                .frame(width: 240 * viewModel.progress, height: 14)
                        }
                        
                        Text("\(viewModel.timeRemaining)s")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(Color(red: 0.2, green: 0.33, blue: 0.27))
                    }
                    
                    // 跳过按钮
                    Button(action: {
                        viewModel.skipExercise()
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
                
                if viewModel.showFailedView {
                    ZStack {
                        Color.black.opacity(0.4)
                            .ignoresSafeArea()
                        StretchFailedView(isPresented: $viewModel.showFailedView, onResume: {
                            viewModel.resumeTimer()
                        })
                    }
                    .onAppear {
                        viewModel.pauseTimer()
                    }
                }
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden()
            .navigationDestination(isPresented: $viewModel.navigateToNext) {
                if viewModel.isLastExercise {
                    StretchSuccessView(onBackToHome: {
                        dismiss()
                    })
                } else {
                    StretchExerciseView(viewModel: viewModel)
                }
            }
        }
    }
} 
