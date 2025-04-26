import SwiftUI

struct StretchEntryView: View {
    @Environment(\.dismiss) private var dismiss
    var onStart: () -> Void
    
    var body: some View {
        Color.black.opacity(0.4)
            .ignoresSafeArea()
            .overlay {
                VStack(spacing: 20) {
                    Text("Time to Stretch!")
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundColor(Color(red: 0.2, green: 0.33, blue: 0.27))
                        .padding(.top, 40)
                    
                    VStack(spacing: 8) {
                        Text("It's been a while!\nLet's take a short break and do a\nfew simple stretches.")
                            .font(.system(size: 18, weight: .regular))
                    }
                    .foregroundColor(.gray)
                    .lineSpacing(7)
                    .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Button(action: {
                        dismiss()
                        onStart()
                    }) {
                        Text("Start")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 200, height: 56)
                            .background(Color(red: 0.43, green: 0.91, blue: 0.83))
                            .cornerRadius(28)
                    }
                    
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Skip This Time")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .underline()
                    }
                    .padding(.bottom, 32)
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
                .shadow(radius: 0)
            }
    }
}

#Preview {
    StretchEntryView(onStart: {})
}

