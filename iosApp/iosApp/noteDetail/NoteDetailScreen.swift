//
//  NoteDetailScreen.swift
//  iosApp
//
//  Created by Kyawt May Hlaing on 20/04/2025.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI
import SwiftfulRouting
import shared

struct NoteDetailScreen: View {
    @StateObject var viewModel: NoteDetailViewModel
    @Environment(\.router) var router
    var onDismissed: () -> Void?
    @Environment(\.presentationMode) var presentation
    
    init(noteId: Int64? = nil, noteDataSource: NoteDataSource, onDismissed: @escaping () -> Void) {
        self._viewModel = StateObject(
            wrappedValue: NoteDetailViewModel(noteId: noteId, noteDataSource: noteDataSource)
        )
        self.onDismissed = onDismissed
    }
    
    var body: some View {
        VStack {
            TextField("Enter a title", text: $viewModel.title)
                .padding(.bottom, 8)
                .font(.title)
                .foregroundColor(Color.black)
            TextField("Enter content here...", text: $viewModel.content, axis: .vertical)
                .lineLimit(5...10)
            Spacer()
        }
        .padding()
        .background(Color(hex: viewModel.noteColor))
        .toolbar {
            ToolbarItem {
                Button {
                    Task {
                        let result = await viewModel.saveNote()
                        if result {
                            onDismissed()
                            router.dismissScreen()
                        }
                    }
                } label: {
                    Image(systemName: "checkmark")
                        .foregroundColor(Color.black)
                }
            }
        }
        .foregroundColor(Color.black)
        .onAppear {
            Task {
                await viewModel.loadNoteIfExists()
            }
        }
    }
}

#Preview {
    EmptyView()
}
