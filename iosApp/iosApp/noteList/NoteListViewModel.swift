//
//  NoteListViewModel.swift
//  iosApp
//
//  Created by Kyawt May Hlaing on 18/04/2025.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import shared

@MainActor class NoteListViewModel: ObservableObject {
    private var noteDataSource: NoteDataSource? = nil
    private let searchNotes = SearchNotes()
    
    @Published var notes: [Note] = []
    @Published var searchText: String = "" {
        didSet {
            if (!searchText.isEmpty) {
                notes = searchNotes.execute(notes: notes, query: searchText)
            }
        }
    }
    
    init(noteDataSource: NoteDataSource? = nil) {
        self.noteDataSource = noteDataSource
    }
    
    
    func loadNotes() async {
        do {
            let fetchedNotes = try await noteDataSource?.getAllNotes() ?? []
            notes = fetchedNotes
        } catch {
            print("Error is here: \(error)")
        }
    }
    
    func setNoteDataSource(noteDataSource: NoteDataSource) async {
        self.noteDataSource = noteDataSource
        await loadNotes()
    }
    
    func deleteNote(id: Int64?) async {
        do {
            if id != nil {
                try await noteDataSource?.deleteNoteById(id: id!)
                await loadNotes()
            }
        } catch {
            print("Error is \(error)")
        }
    }
}
