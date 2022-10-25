//
//  SearchBar.swift
//  ToDoList
//
//  Created by Simon Ng on 15/4/2020.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import SwiftUI
import MapKit

struct SearchBar: View {
    @State private var isEditing = false
    
    @StateObject private var viewModel = LocalSearchViewModel()
    @StateObject var stationprovider: StationProvider
        
    var body: some View {
        VStack {
            HStack {
                TextField("Search ...", text: $viewModel.poiText)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.black)
                    )
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)
                            
                            if isEditing {
                                Button(action: {
                                    self.viewModel.poiText = ""
                                    
                                }) {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                }
                            }
                        }
                    )
                    .padding(.horizontal, 10)
                    .onTapGesture {
                        self.isEditing = true
                    }
                
                if isEditing {
                    Button(action: {
                        self.isEditing = false
                        self.viewModel.poiText = ""
                        
                        // Dismiss the keyboard
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }) {
                        Text("Cancel")
                            .bold()
                            .foregroundColor(Color.primary)
                            .frame(minWidth: 20, minHeight: 20)
                    }
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                }
            }
            
            if isEditing {
                List(viewModel.viewData) { item in
                    Button(action: {
                        stationprovider.setDestination(inLocation: item.location)
                        print("\(stationprovider.destination)\n\(stationprovider.closeststation)\n\(stationprovider.destinationstation)")
                        self.isEditing = false
                        self.viewModel.poiText = ""

                        // Dismiss the keyboard
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }) {
                        VStack(alignment: .leading) {
                            Text(item.title)
                                .foregroundColor(.primary)
                            Text(item.subtitle)
                                .foregroundColor(.secondary)
                        }
                    }
                }.onAppear {
                    UIScrollView.appearance().keyboardDismissMode = .onDrag
                }
            }
        }.background(isEditing ? Color(UIColor.secondarySystemBackground) : Color.clear)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(stationprovider: StationProvider())
    }
}
