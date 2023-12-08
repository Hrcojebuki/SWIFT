//
//  SearchBar.swift
//  MovieApp
//
//  Created by Hrvoje Buljan (RIT Student) on 06.12.2023..
//

import SwiftUI

//
//  SearchBar.swift
//  NetflixClone (iOS)
//
//  Created by Gan Tu on 7/3/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    @State private var isEditing = true
    
    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                Color.gray
                    .frame(height: 36)
                    .cornerRadius(8)
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color.white)
                        .padding(.leading, 10)
                    
                    TextField("Search", text: $text)
                        .padding(7)
                        .padding(.leading, -7)
                        .background(Color.gray)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .onTapGesture {
                            isEditing = true
                        }
                    
                    if !text.isEmpty {
                        Button(action: {
                            text = ""
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                                .frame(width: 35, height: 35)
                        })
                        .padding(.trailing, 10)
                    }
                    
                }
            }
            .animation(.default)
            
            if isEditing{
                Button(action: {
                    // clear text, hide both buttons, give up first-responder
                    text = ""
                    isEditing = false
                }, label: {
                    Text("Cancel")
                        .foregroundColor(.white)
                })
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
}

struct SearchBarView: UIViewRepresentable {

    let placeholder: String
    @Binding var text: String
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.placeholder = placeholder
        searchBar.searchBarStyle = .minimal
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.delegate = context.coordinator
        return searchBar
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: self.$text)
    }
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            self.text = searchText
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
    }

}

#Preview {
    ZStack {
        Color.black.edgesIgnoringSafeArea(.all)
        SearchBar(text: .constant(""))
            .padding()
    }
}
