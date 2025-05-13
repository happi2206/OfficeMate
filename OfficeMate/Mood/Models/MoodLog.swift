//
//  MoodLog.swift
//  OfficeMate
//
//  Created by Happiness Adeboye on 08/05/2025.
//

import SwiftUI

struct MoodOption: Identifiable, Equatable {
    let id = UUID()
    let emoji: String
    let label: String
}

struct MoodLog: Codable, Identifiable {
    var id = UUID()
    let date: Date
    let emoji: String
    let label: String
    let thought: String
    let note: String
}
