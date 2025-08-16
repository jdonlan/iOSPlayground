//
//  Theme.swift
//  DisneyCharacters
//
//  Created by Joshua Donlan on 8/16/25.
//

import SwiftUICore

protocol AppTheme {
        var primaryColor: Color { get }
        var secondaryColor: Color { get }
        var surfaceColor: Color { get }
    }

    struct LightTheme: AppTheme {
        var primaryColor: Color = .black
        var secondaryColor: Color = .gray
        var surfaceColor: Color = .white
    }

    struct DarkTheme: AppTheme {
        var primaryColor: Color = .white
        var secondaryColor: Color = .gray
        var surfaceColor: Color = .black
    }
