//
//  HomeView.swift
//  MovieApp
//
//  Created by Raphael Cerqueira on 18/01/21.
//

import SwiftUI
import SDWebImageSwiftUI

enum Tabs: Hashable{
    case home
    case search
}

struct HomeView: View {
    @State private var selectedTab = Tabs.home
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack {
                        FeaturedMoviesView()

                        MoviesListView(title: "Popular", sortBy: "popularity.desc")

                        MoviesListView(title: "New Releases", sortBy: "release_date.desc", orientation: "vertical")
                    }
                    .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                })
                .background(Color("background"))
                .navigationBarHidden(true)
                .ignoresSafeArea(.all, edges: .all)
            }
            .tabItem {
                Image(systemName: "house")
            }
            .tag(Tabs.home)
            
            SearchView(sortBy: "popularity.desc")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .tag(Tabs.search)
        }
        
    }
}

#Preview {
    HomeView()
}
