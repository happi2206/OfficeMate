//
//  EmptyStateView.swift
//  OfficeMate
//
//  Created by Happiness Adeboye on 09/05/2025.
//


import SwiftUI

struct EmptyStateView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Image(systemName: "tray")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.gray.opacity(0.4))

            Text("Nothing Here Yet")
                .font(.system(size: 24, weight: .semibold))

            Text("When there’s something to show, it’ll appear here.")
                .font(.system(size: 16))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

            Spacer()

            Button(action: {
                dismiss()
            }) {
                Text("Go Back")
                    .font(.system(size: 16, weight: .medium))
                    .padding(.horizontal, 32)
                    .padding(.vertical, 12)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            .padding(.bottom, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
        .ignoresSafeArea()
    }
}
