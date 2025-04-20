//
//  NoteItem.swift
//  iosApp
//
//  Created by Kyawt May Hlaing on 18/04/2025.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI
import shared

struct NoteItem: View {
    var note: Note
    var onDeleteClicked: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(note.title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
                Spacer()
                Button {
                    onDeleteClicked()
                } label: {
                    Image(systemName: "xmark")
                        .fontWeight(.bold)
                }
            }
            Text(note.content)
            HStack {
                Spacer()
                Text("Apr 17, 2025")
            }
        }
        .foregroundColor(Color.black.opacity(0.7))
        .padding()
        .background(Color(hex: note.colorHex))
        .cornerRadius(5)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

#Preview {
    NoteItem(
        note: Note(
            id: nil,
            title: "Note Title",
            content: "Content",
            colorHex: 0xFF3434,
            created: DateTimeUtil().now()
        ),
        onDeleteClicked: {}
    )
}
