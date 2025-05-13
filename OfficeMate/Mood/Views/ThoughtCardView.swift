//
//  ThoughtFileView.swift
//  OfficeMate
//
//  Created by Happiness Adeboye on 03/05/2025.
//


import SwiftUI

struct ThoughtCardView: View {
    @Binding var thought: String

    private let characterLimit = 20

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 16) {
                Image("IconMoodNote")
                    .resizable()
                    .frame(width: 48, height: 48)

                Text("Express a thought")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
            }

            VStack(alignment: .leading, spacing: 4) {
                if #available(iOS 17.0, *) {
                    TextField("What word or sentence best describes your mood? e.g. Grateful", text: $thought)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.system(size: 12, weight: .semibold))
                        .onChange(of: thought) {
                            if thought.count > characterLimit {
                                thought = String(thought.prefix(characterLimit))
                            }
                        }
                } else {
                    // Fallback on earlier versions
                }

                HStack {
                    Spacer()
                    Text("\(thought.count)/\(characterLimit)")
                        .font(.system(size: 10))
                        .foregroundColor(thought.count > characterLimit ? .red : .gray)
                }

            }
        }
        .padding(16)
        .frame(width: 360, height: 140)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
        .padding(.horizontal, 24)
    }
}
