//
//  LorcanaToolbar.swift
//  DisneyCharacters
//
//  Created by Joshua Donlan on 8/16/25.
//

import SwiftUI

struct LorcanaToolbar: ToolbarContent {
    var body: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Image("dlclogo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .scaledToFit()
        }
    }
}
