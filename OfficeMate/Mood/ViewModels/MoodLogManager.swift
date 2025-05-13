//
//  MoodLogManager.swift
//  OfficeMate
//
//  Created by Happiness Adeboye on 08/05/2025.
//

import Foundation

class MoodLogManager: ObservableObject {
    @Published var logs: [MoodLog] = []
    let saveKey = "moodLogs"

    init() {
        load()
    }

    func addLog(_ log: MoodLog) {
        guard !hasLoggedToday else { return }
        logs.append(log)
        save()
    }
    
    func updateLog(for date: Date, with updatedLog: MoodLog) {
        if let index = logs.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: date) }) {
            logs[index] = updatedLog
        }
    }


    var hasLoggedToday: Bool {
        logs.contains { Calendar.current.isDateInToday($0.date) }
    }

    private func save() {
        if let encoded = try? JSONEncoder().encode(logs) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }

    private func load() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([MoodLog].self, from: data) {
            logs = decoded
        }
    }
}
