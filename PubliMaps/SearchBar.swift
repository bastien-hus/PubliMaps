//
//  SearchBar.swift
//  PubliMaps
//
//  Created by Bastien HUSLER on 17/03/2022.
//

import SwiftUI
 
struct SearchBar: View {
    @Binding var search: String
 
    @State private var isEditing = false
 
    var body: some View {
        HStack {
 
            TextField("Search", text: $search)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black)
                )
                .padding([.leading, .bottom, .trailing], 10)
                .onTapGesture {
                    self.isEditing = true
                }
 
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.search = ""
 
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
            }
        }
    }
}
