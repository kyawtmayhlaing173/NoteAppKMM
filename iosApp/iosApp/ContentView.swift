//
//  ContentView.swift
//  iosApp
//
//  Created by Kyawt May Hlaing on 18/04/2025.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI
import SwiftfulRouting
import shared

struct ContentView: View {
    private let databaseModule = DatabaseModule()
    
    var body: some View {
        RouterView { _ in
            NoteListScreen(noteDataSource: databaseModule.noteDataSource)
        }
    }
}

#Preview {
    ContentView()
}
