//
//  Environment.swift
//  DisneyCharacters
//
//  Created by Joshua Donlan on 8/16/25.
//

import SwiftUICore

struct ThemeKey: EnvironmentKey {
    static let defaultValue: AppTheme = DarkTheme() // Default theme
}

extension EnvironmentValues {
    var appTheme: AppTheme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}
