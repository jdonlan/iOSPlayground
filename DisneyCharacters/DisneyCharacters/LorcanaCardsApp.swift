//
//  LorcanaCardsApp.swift
//  DisneyCharacters
//
//  Created by Joshua Donlan on 8/14/25.
//

import SwiftUI

@main
struct LorcanaCardsApp: App {
    @StateObject private var appDataManager = AppDataManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appDataManager)
                .task {
                    await appDataManager.initializeAppData()
                }
        }
    }
}
