//
//  NewEmojiView.swift
//  OfficeMate
//
//  Created by Happiness Adeboye on 03/05/2025.
//

import SwiftUI

struct MoodOption: Identifiable, Equatable {
    let id = UUID()
    let emoji: String
    let label: String
}

let moodOptions: [MoodOption] = [
    MoodOption(emoji: "😄", label: "Happy"),
    MoodOption(emoji: "😔", label: "Sad"),
    MoodOption(emoji: "😐", label: "Neutral"),
    MoodOption(emoji: "😊", label: "Calm"),
    MoodOption(emoji: "😠", label: "Frustrated")
]

struct MoodCardView: View {
    @Binding var selectedMood: MoodOption?

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("How are you feeling?")
                .font(.system(size: 18, weight: .semibold))

            HStack(spacing: 12) {
                ForEach(moodOptions) { mood in
                    VStack(spacing: 7) {
                        ZStack {
                            Circle()
                                .fill(selectedMood == mood ? Color.blue.opacity(0.2) : Color.clear)
                                .frame(width: 55, height: 55)
                            Text(mood.emoji)
                                .font(.system(size: 28))
                        }
                        Text(mood.label)
                            .font(.system(size: 11))
                    }
                    .onTapGesture {
                        selectedMood = mood
                    }
                }
            }
        }
        .padding(10)
        .frame(width: 360, height: 150)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
        .padding(.horizontal, 22)
    }
}
