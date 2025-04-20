//
//  NoteDetailViewModel.swift
//  iosApp
//
//  Created by Kyawt May Hlaing on 20/04/2025.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import shared

@MainActor class NoteDetailViewModel: ObservableObject {
    var noteId: Int64?
    private var noteDataSource: NoteDataSource
    
    @Published var title: String = ""
    @Published var content: String = ""
    @Published var noteColor: Int64 = Note.Companion().generateRandomColor()
    
    @Published var note: Note? = nil {
        didSet {
            title = note?.title ?? ""
            content = note?.content ?? ""
        }
    }
    
    init(noteId: Int64? = nil, noteDataSource: NoteDataSource) {
        self.noteId = noteId
        self.noteDataSource = noteDataSource
    }
    
    func loadNoteIfExists() async {
        do {
            if let id = noteId {
                note = try await noteDataSource.getNoteById(id: id)
                noteColor = note?.colorHex ?? Note.Companion().generateRandomColor()
            }
        } catch {
            print("Error is \(error)")
        }
    }
    
    func saveNote() async -> Bool {
        do {
            
            try await noteDataSource.insertNote(
                note: Note(
                    id: note?.id,
                    title: title,
                    content: content,
                    colorHex: noteColor,
                    created: DateTimeUtil().now()
                )
            )
            return true
        } catch {
            print("Error is \(error)")
            return false
        }
    }
}
