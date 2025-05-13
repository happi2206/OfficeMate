import SwiftUI
import UIKit
import ImageIO

struct GIFImage: UIViewRepresentable {
    let name: String
    
    init(name: String) {
        self.name = name
        print("GIFImage init for \(name)")
    }
    
    func makeUIView(context: Context) -> UIImageView {
        print("GIFImage makeUIView for \(name)")
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        if let gifURL = Bundle.main.url(forResource: name, withExtension: "gif") {
            print("✅ Found gif at: \(gifURL)")
            if let data = try? Data(contentsOf: gifURL) {
                if let source = CGImageSourceCreateWithData(data as CFData, nil) {
                    let frameCount = CGImageSourceGetCount(source)
                    var images = [UIImage]()
                    var totalDuration: TimeInterval = 0
                    
                    for i in 0..<frameCount {
                        if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                            // 创建缩放后的图片
                            let size = CGSize(width: 262, height: 325)
                            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
                            let context = UIGraphicsGetCurrentContext()
                            context?.interpolationQuality = .high
                            
                            // 保存当前状态
                            context?.saveGState()
                            
                            // 设置变换以保持正确的方向
                            context?.translateBy(x: size.width, y: size.height)
                            context?.scaleBy(x: -1.0, y: -1.0)
                            
                            // 绘制图片
                            context?.draw(cgImage, in: CGRect(origin: .zero, size: size))
                            
                            // 恢复状态
                            context?.restoreGState()
                            
                            if let scaledImage = UIGraphicsGetImageFromCurrentImageContext() {
                                images.append(scaledImage)
                            }
                            UIGraphicsEndImageContext()
                            
                            if let properties = CGImageSourceCopyPropertiesAtIndex(source, i, nil) as? [String: Any],
                               let gifProperties = properties[kCGImagePropertyGIFDictionary as String] as? [String: Any],
                               let duration = gifProperties[kCGImagePropertyGIFDelayTime as String] as? Double {
                                totalDuration += duration
                            }
                        }
                    }
                    
                    print("GIF frame count: \(images.count), total duration: \(totalDuration)")
                    
                    if !images.isEmpty {
                        imageView.animationImages = images
                        imageView.animationDuration = totalDuration
                        imageView.animationRepeatCount = 0
                        imageView.startAnimating()
                    }
                }
            } else {
                print("Failed to load data at path: \(gifURL)")
            }
        } else {
            print("❌ Failed to find gif: \(name).gif in main bundle")
        }
        
        return imageView
    }
    
    func updateUIView(_ uiView: UIImageView, context: Context) {}
}

// UIImage GIF 扩展
extension UIImage {
    static func gifImageWithData(_ data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("Failed to create image source from data")
            return nil
        }
        var images = [UIImage]()
        var duration: TimeInterval = 0
        
        let count = CGImageSourceGetCount(source)
        print("GIF frame count: \(count)")
        
        for i in 0..<count {
            if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(UIImage(cgImage: cgImage))
                if let properties = CGImageSourceCopyPropertiesAtIndex(source, i, nil) as? [String: Any],
                   let gifProperties = properties[kCGImagePropertyGIFDictionary as String] as? [String: Any],
                   let delayTime = gifProperties[kCGImagePropertyGIFDelayTime as String] as? Double {
                    duration += delayTime
                }
            }
        }
        
        if images.isEmpty {
            print("No images were created from the GIF data")
            return nil
        }
        
        print("Created animated image with \(images.count) frames, duration: \(duration)")
        return UIImage.animatedImage(with: images, duration: duration)
    }
}

