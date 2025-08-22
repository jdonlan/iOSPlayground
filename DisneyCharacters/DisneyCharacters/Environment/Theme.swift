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
    var padding: CGFloat { get }
    var paddingSmall: CGFloat { get }
}

struct LightTheme: AppTheme {
    var primaryColor: Color = .black
    var secondaryColor: Color = .gray
    var surfaceColor: Color = .white
    var padding = CGFloat(16)
    var paddingSmall = CGFloat(4)
}

struct DarkTheme: AppTheme {
    var primaryColor: Color = .white
    var secondaryColor: Color = .gray
    var surfaceColor: Color = .black
    var padding = CGFloat(16)
    var paddingSmall = CGFloat(4)
}
