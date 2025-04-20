//
//  HideableSearchTextField.swift
//  iosApp
//
//  Created by Kyawt May Hlaing on 18/04/2025.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI

struct HideableSearchTextField: View {
    @Binding var searchText: String
    @Binding var isSearchActive: Bool
    
    var body: some View {
        HStack(spacing: 24) {
            TextField("Search", text: $searchText)
                .padding(8)
                .padding(.leading, 12)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
            Button {
                isSearchActive = false
                searchText = ""
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(Color.white.opacity(0.8))
            }

        }
        .opacity(isSearchActive ? 1: 0)
    }
}

#Preview {
    @State var isSearchActive: Bool = true
    @State var searchText: String = ""
    HideableSearchTextField(searchText: $searchText, isSearchActive: $isSearchActive)
}
