//
//  MoodLoggedSuccessView.swift
//  OfficeMate
//
//  Created by Happiness Adeboye on 08/05/2025.
//
import SwiftUI

struct MoodLoggedSuccessView: View {
    let initialMood: MoodLog
    let onClose: () -> Void
    var onSave: ((_ mood: MoodOption, _ thought: String, _ note: String) -> Void)? = nil

    @State private var isEditing = false
    @State private var selectedMood: MoodOption?
    @State private var thought: String
    @State private var note: String

    init(
        mood: MoodLog,
        onClose: @escaping () -> Void,
        onSave: ((_ mood: MoodOption, _ thought: String, _ note: String) -> Void)? = nil
    ) {
        self.initialMood = mood
        self.onClose = onClose
        self.onSave = onSave
        _selectedMood = State(initialValue: MoodOption(emoji: mood.emoji, label: mood.label))

        _thought = State(initialValue: mood.thought)
        _note = State(initialValue: mood.note)
    }

    var body: some View {
        
        VStack(spacing: 16) {
            HStack {
                Text("Your Mood Today")
                    .font(.system(size: 20, weight: .semibold))
                Spacer()
                Button(isEditing ? "Cancel" : "Edit") {
                    isEditing.toggle()
                }
                .font(.system(size: 14, weight: .semibold))
            }

            Text(selectedMood?.emoji ?? "❓")
                .font(.system(size: 40))

            if isEditing {
                MoodCardView(selectedMood: $selectedMood)
            } else {
                Text(selectedMood?.label ?? "Unknown Mood")
                    .font(.system(size: 18, weight: .medium))
                    .frame(maxWidth: .infinity, alignment: .leading)

            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Thought:")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.gray)
                    .frame(alignment: .leading)

                if isEditing {
                    TextField("Update your thought", text: $thought)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.system(size: 16))
                } else {
                    Text(thought)
                        .font(.system(size: 16))
                        .frame(maxWidth: .infinity,alignment: .leading)
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Note:")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.gray)

                if isEditing {
                    TextEditor(text: $note)
                        .frame(height: 80)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                } else {
                    Text(note)
                        .font(.system(size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }

            HStack {
                if isEditing {
                    Button("Save") {
                        if let onSave {
                            if let mood = selectedMood {
                                onSave(mood, thought, note)
                                isEditing = false
                            }

                        }
                        isEditing = false
                    }
                    .font(.system(size: 16, weight: .semibold))
                    .padding(.vertical, 12)
                    .padding(.horizontal, 32)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                }

                Button("Close") {
                    onClose()
                }
                .font(.system(size: 16, weight: .semibold))
                .padding(.vertical, 12)
                .padding(.horizontal, 32)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(20)
            }
        }
        .padding(24)
        .frame(maxWidth: 400)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding()
    }
}
