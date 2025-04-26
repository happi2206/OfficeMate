import SwiftUI
import UIKit

struct GIFImage: UIViewRepresentable {
    let name: String
    
    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        // Size
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        if let path = Bundle.main.path(forResource: name, ofType: "gif") {
            let url = URL(fileURLWithPath: path)
            if let gifData = try? Data(contentsOf: url),
               let source =  CGImageSourceCreateWithData(gifData as CFData, nil) {
                
                let frameCount = CGImageSourceGetCount(source)
                var images: [UIImage] = []
                var totalDuration: TimeInterval = 0
                
                for i in 0..<frameCount {
                    if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                        // image size
                        let image = UIImage(cgImage: cgImage).resized(to: CGSize(width: 131, height: 162.5))
                        images.append(image)
                        
                        if let properties = CGImageSourceCopyPropertiesAtIndex(source, i, nil) as? [String: Any],
                           let gifProperties = properties[kCGImagePropertyGIFDictionary as String] as? [String: Any],
                           let delayTime = gifProperties[kCGImagePropertyGIFDelayTime as String] as? Double {
                            totalDuration += delayTime
                        }
                    }
                }
                
                imageView.animationImages = images
                imageView.animationDuration = totalDuration
                imageView.startAnimating()
            }
        }
        
        return imageView
    }
    
    func updateUIView(_ uiView: UIImageView, context: Context) {}
}

// image scale
extension UIImage {
    func resized(to newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        self.draw(in: CGRect(origin: .zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? self
    }
}

struct Stretch_1_View: View {
    @State private var timeRemaining: Int = 15
    @State private var progress: CGFloat = 1.0
    @State private var navigateToStretch2: Bool = false
    @State private var showFailedView: Bool = false
    @Environment(\.dismiss) private var dismiss
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var isTimerPaused: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Content
                VStack(spacing: 0) {
                    // Navi
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
                        
                        // slider
                        Text("1/6")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 6)
                            .background(Color(red: 0.85, green: 0.99, blue: 0.97))
                            .cornerRadius(16)
                    }
                    .padding(.top, 16)
                    
                    // Title
                    Text("Head Side to Side")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(Color(red: 0.2, green: 0.33, blue: 0.27))
                        .padding(.top, 40)
                    
                    // GIF image
                    GIFImage(name: "clean_single_nod_animation")
                        .frame(width: 262, height: 325)
                        .padding(.top, 60)
                    
                    Spacer()
                    
                    // description
                    Text("Gently turn your head to the left,\nthen to the right. Repeat slowly.")
                        .font(.system(size: 16))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.47, green: 0.47, blue: 0.47))
                        .padding(.bottom, 40)
                    
                    // Counting down
                    VStack(spacing: 6) {
                        
                        ZStack(alignment: .leading) {
                            
                            RoundedRectangle(cornerRadius: 7)
                                .fill(Color(red: 0.93, green: 0.93, blue: 0.93))
                                .frame(width: 240, height: 14)
                            
                            
                            RoundedRectangle(cornerRadius: 7)
                                .fill(Color(red: 0.43, green: 0.91, blue: 0.83))
                                .frame(width: 240 * progress, height: 14)  //
                            
                        }
                        
                        
                        Text("\(timeRemaining)s")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(Color(red: 0.2, green: 0.33, blue: 0.27)) // #335546
                    }
                    
                    // Skip button
                    Button(action: {
                        navigateToStretch2 = true  // Next Page
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
                
                // showFailedView is true
                
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
                        navigateToStretch2 = true
                    }
                }
            }
            .navigationDestination(isPresented: $navigateToStretch2) {
                Stretch_2_View()
            }
        }
    }
}

#Preview {
    Stretch_1_View()
}
