//
//  SearchView.swift
//  MovieApp
//
//  Created by Hrvoje Buljan (RIT Student) on 06.12.2023..
//

import SwiftUI

struct SearchView: View {
    @ObservedObject private var viewModel = HomeViewModel()
    @State private var searchText = ""
    var sortBy: String
    
    var body: some View {
            VStack {
//                TextField("Search", text: $searchText, onCommit: {
//                    viewModel.fetchData(sortBy: sortBy)
//                })
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
                
//                SearchBarView(placeholder: "Search movies", text: self.$viewModel.query)
//                                    .listRowInsets(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))

                List(viewModel.items ?? viewModel.placeholders) { movie in
                    MovieItemView(item: movie, orientation: "vertical")
                }
            }
            .onAppear {
                viewModel.fetchData(sortBy: sortBy)
            }
        }
}

#Preview {
    SearchView(sortBy: "popularity.desc")
}
