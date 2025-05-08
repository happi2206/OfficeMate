//
//  MoodView.swift
//  OfficeMate
//
//  Created by Happiness Adeboye on 02/05/2025.

import SwiftUI

struct MoodViewSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedMood: MoodOption? = nil
    @State private var thought: String = ""
    @State private var note: String = ""

    @State private var showConfirmation = false

    private var canLogMood: Bool {
        selectedMood != nil && !thought.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var onLogMood: (MoodOption?, String, String) -> Void

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HeaderSection()

                VStack(spacing: 16) {
                    MoodCardView(selectedMood: $selectedMood)
                    ThoughtCardView(thought: $thought)
                    NoteCardView(note: $note)
                }
                .padding(.top, 32)

                Spacer()

                // Log Mood Button
                Button(action: {
                    showConfirmation = true
                    onLogMood(selectedMood, thought, note)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        showConfirmation = false
                        dismiss()
                    }
                }) {
                    Text("Log Mood")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(canLogMood ? Color(red: 0.43, green: 0.91, blue: 0.83) : Color.gray)
                        .cornerRadius(28)
                }
                .disabled(!canLogMood)
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }

            // Close Button
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

            
            if showConfirmation {
                VStack {
                    Spacer()
                    ToastView()
                        .padding(.bottom, 80)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
                .animation(.easeInOut(duration: 0.3), value: showConfirmation)
            }
        }
        .background(Color(red: 0.96, green: 0.96, blue: 0.96))
        .ignoresSafeArea()
    }
}

struct HeaderSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Log Your Mood")
                .font(.system(size: 24, weight: .semibold))
            Text("Take a moment to check in with yourself")
                .font(.system(size: 14))
                .foregroundColor(.gray)
        }
        .padding(.top, 100)
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


struct ToastView: View {
    var body: some View {
        HStack(spacing: 8) {
            Text("🧘‍♀️ Mood Logged Successfully!")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.green)
        .cornerRadius(14)
        .shadow(radius: 4)
    }
}
