//
//  NoteCardView.swift
//  OfficeMate
//
//  Created by Happiness Adeboye on 03/05/2025.
//

import SwiftUI

struct NoteCardView: View {
    @Binding var note: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Write a note (Optional)")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.gray)

            TextEditor(text: $note)
                .frame(height: 80)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
        }
        .padding(.horizontal, 24)
    }
}
