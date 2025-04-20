//
//  NoteListScreen.swift
//  iosApp
//
//  Created by Kyawt May Hlaing on 18/04/2025.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI
import shared
import SwiftfulRouting

struct NoteListScreen: View {
    var noteDataSource: NoteDataSource
    @StateObject private var viewModel = NoteListViewModel(noteDataSource: nil)
    
    @State var isSearchActive = false
    
    @Environment(\.router) var router
    
    init(noteDataSource: NoteDataSource) {
        self.noteDataSource = noteDataSource
    }
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    if (!isSearchActive) {
                        HStack {
                            Text("xxxxxx")
                                .hidden()
                            Spacer()
                            Text("All notes")
                                .font(.title)
                            Spacer()
                            Image(systemName: "magnifyingglass")
                                .onTapGesture {
                                    isSearchActive = true
                                }
                            Image(systemName: "plus")
                                .onTapGesture {
                                    router.showScreen(.sheet) { _ in
                                        NoteDetailScreen(
                                            noteId: nil,
                                            noteDataSource: noteDataSource, onDismissed: {
                                                Task {
                                                    await viewModel.loadNotes()
                                                }
                                            }
                                        )
                                    }
                                }
                        }
                    } else {
                        HideableSearchTextField(
                            searchText: $viewModel.searchText,
                            isSearchActive: $isSearchActive
                        )
                    }
                }
                .padding()
                
                ScrollView {
                    VStack {
                        ForEach(viewModel.notes, id: \.self) { note in
                            NoteItem(
                                note: note) {
                                    Task {
                                        await viewModel.deleteNote(id: note.id?.int64Value)
                                    }
                                }
                                .onTapGesture {
                                    router.showScreen(.sheet) { _ in
                                        NoteDetailScreen(
                                            noteId: note.id?.int64Value,
                                            noteDataSource: noteDataSource,
                                            onDismissed: {
                                                await viewModel.loadNotes()
                                            }
                                        )
                                    }
                                }
                        }
                    }
                }
            }
            .onAppear() {
                Task {
                    await viewModel.setNoteDataSource(noteDataSource: noteDataSource)
                }
            }
            .onChange(of: viewModel.searchText) { oldValue, newValue in
                if (newValue.isEmpty) {
                    Task {
                        await viewModel.loadNotes()
                    }
                }
            }
        }
    }
}

#Preview {
    NoteListScreen(noteDataSource: DatabaseModule().noteDataSource)
}
