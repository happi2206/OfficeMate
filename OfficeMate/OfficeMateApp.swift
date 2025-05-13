//
//  OfficeMateApp.swift
//  OfficeMate
//
//  Created by 王增凤 on 25/4/2025.
//

import SwiftUI

@main
struct OfficeMateApp: App {
    @StateObject var moodLogManager = MoodLogManager()
    var body: some Scene {
        WindowGroup {
            HomeView().environmentObject(moodLogManager) 
        }
    }
}
