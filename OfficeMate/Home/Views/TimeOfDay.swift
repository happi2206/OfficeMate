import SwiftUI

enum TimeOfDay {
    case morning    // morning
    case afternoon  // noon
    case evening    // evening
    
    static func current() -> TimeOfDay {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 5..<12:
            return .morning
        case 12..<17:
            return .afternoon
        default:
            return .evening
        }
    }
    
    var greeting: String {
        switch self {
        case .morning:
            return "Good Morning ~"
        case .afternoon:
            return "Good Afternoon ~"
        case .evening:
            return "Good Evening ~"
        }
    }
    
    var backgroundImage: String {
        switch self {
        case .morning:
            return "HomeMorning"
        case .afternoon:
            return "HomeAfternoon"
        case .evening:
            return "HomeEvening"
        }
    }
}

// View components
struct TimeBackgroundPreview: View {
    let timeOfDay: TimeOfDay
    
    var body: some View {
        ZStack {
            Image(timeOfDay.backgroundImage)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                Text(timeOfDay.greeting)
                    .font(.system(size: 16))
                    .foregroundColor(.black.opacity(0.6))
            }
        }
    }
}

#Preview {
    TabView {
        TimeBackgroundPreview(timeOfDay: .morning)
            .tabItem {
                Text("Morning")
            }
        
        TimeBackgroundPreview(timeOfDay: .afternoon)
            .tabItem {
                Text("Afternoon")
            }
        
        TimeBackgroundPreview(timeOfDay: .evening)
            .tabItem {
                Text("Evening")
            }
    }
}
