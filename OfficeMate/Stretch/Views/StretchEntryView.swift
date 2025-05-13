import SwiftUI

struct StretchEntryView: View {
    @Binding var isPresented: Bool
    @EnvironmentObject private var stretchManager: StretchManager
    var onStart: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Time to Stretch!")
                .font(.system(size: 28, weight: .semibold))
                .foregroundColor(Color(red: 0.2, green: 0.33, blue: 0.27))
                .padding(.top, 76)
            
            Text("It's been a while!\nLet's take a short break and do a\nfew simple stretches.")
                .font(.system(size: 18))
                .foregroundColor(.gray)
                .lineSpacing(7)
                .multilineTextAlignment(.center)
                .padding(.top, 24)
            
            Spacer()
            
            Button(action: {
                onStart()
                isPresented = false
            }) {
                Text("Start")
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .frame(width: 200, height: 56)
                    .background(Color(red: 0.43, green: 0.91, blue: 0.83))
                    .cornerRadius(28)
            }
            
            Button(action: {
                isPresented = false
            }) {
                Text("Skip This Time")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .underline()
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
    StretchEntryView(isPresented: .constant(true), onStart: {})
        .environmentObject(StretchManager())
}

