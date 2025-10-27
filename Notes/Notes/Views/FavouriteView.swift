//
//  FavouriteView.swift
//  Notes
//
//  Created by HarshaHrudhay on 08/08/25.
//

import SwiftUI

struct FavouriteView: View {
    
    @Binding var favouriteNotes: [NoteViewModel]
    @Environment(\.managedObjectContext) var viewContext
    
//    @State private var notes : [NoteViewModel] = []
    
    @State var searchedNote : String = ""
    
    var notepadList:[NoteViewModel]{
        if self.searchedNote.isEmpty {
            return favouriteNotes
        }else {
            return self.favouriteNotes.filter{$0.title.localizedStandardContains(searchedNote)}
        }
        
    }
    
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                RadialGradient(
                    gradient: Gradient(colors: [Color.appbg1, Color.appbg2]),
                    center: .center,
                    startRadius: 20,
                    endRadius: 500
                )
                .edgesIgnoringSafeArea(.all)
                
                VStack{
                    
                    Text("Favourites")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.textbg)
                        .padding()
                    
                    ZStack{
                        
                        TextField("Search", text: $searchedNote)
                            .padding(.horizontal, 50)
                            .padding(7)
                            .background(Color.white)
                            .cornerRadius(29)
                            .padding()
                            .padding(.top, -30)
                        
                        Image(systemName: "magnifyingglass")
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                            .padding(.trailing, 290)
                            .padding(.bottom, 30)
                        
                    }
                    
                    List {
                        
                        if notepadList.isEmpty {
                            Text("Nothing to show")
                                .foregroundColor(.gray)
                                .font(.system(size: 17, weight: .regular))
                                .padding()
                        } else {
                            
                            
                            
                            ForEach(notepadList) { note in
                                VStack(alignment: .leading) {
                                    
                                    Text(note.title)
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundStyle(Color.black)
                                        .padding(.bottom, 5)
                                    
                                    Text(note.description)
                                        .font(.system(size: 15, weight: .regular))
                                        .foregroundStyle(.black)
                                        .lineLimit(5)
                                    
                                }
                                //                        .padding()
                                //                        .background(Color("background"))
                                .cornerRadius(10)
                            }
                            .onDelete { indexSet in
                                favouriteNotes.remove(atOffsets: indexSet)
                            }
                        }
                        //                    .onDelete(perform: deleteFavorite())
                    }
                    .padding(.horizontal)
                    
                    .scrollContentBackground(.hidden)
                    
                }
            }
            
        }
        
    }
    
    
    
}


//#Preview {
//    FavouriteView(favouriteNotes: <#Binding<[NoteViewModel]>#>)
//}

