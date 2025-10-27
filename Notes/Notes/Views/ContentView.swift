//
//  ContentView.swift
//  Notes
//
//  Created by HarshaHrudhay on 08/08/25.
//
import SwiftUI

struct ContentView: View {
    
    @State private var favouriteNotes: [NoteViewModel] = []
    
    var body: some View {
        
        NavigationStack {
            ZStack{
                
                TabView {
                    
                    HomePageView(favouriteNotes: $favouriteNotes)
                        .tabItem{
                            Image(systemName: "house")
                            Text("Home")
                        }
                    FavouriteView(favouriteNotes: $favouriteNotes)
                        .tabItem{
                            Image(systemName: "heart")
                            Text("Favourites")
                        }
                    
                }
                .accentColor(.iconbg)
            }
        }
    }
}

#Preview {
    ContentView()
}
