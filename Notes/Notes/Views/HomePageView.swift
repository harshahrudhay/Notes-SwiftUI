//
//  HomePageView.swift
//  Notes
//
//  Created by HarshaHrudhay on 08/08/25.
//

import SwiftUI
import CoreData

struct HomePageView: View {
    
    @State private var notes : [NoteViewModel] = []
    
    //    @ObservedObject var note: NoteViewModel
    
    @Environment(\.managedObjectContext) var viewContext
    
    // @State private var showAddNote = false //
    
    @Binding  var favouriteNotes: [NoteViewModel]
    
    @State var searchedNote : String = ""
    
    var notepadList:[NoteViewModel]{
        if self.searchedNote.isEmpty {
            return notes
        }else {
            return self.notes.filter{$0.title.localizedStandardContains(searchedNote)}
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
                    
                    VStack{
                        Text("Notes App")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.textbg)
                            .padding()
                    }
                    
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
                    
                    
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 20)
//                            .fill(.ultraThinMaterial)
//                            .background(Color.clear)
//                            .shadow(radius: 5)
                        
                        List {
                            if notepadList.isEmpty {
                                VStack {
                                    Spacer()
                                    Text("No notes found.")
                                        .font(.title)
                                        .foregroundColor(.gray)
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                            } else {
                                ForEach(notepadList) { note in
                                    HStack {
                                        NavigationLink(destination: NoteAddView(noteToEdit: note) { updatedNote in
                                            if let index = notes.firstIndex(where: { $0.id == updatedNote.id }) {
                                                notes[index] = updatedNote
                                            }
                                            // added else 1.1
                                            else {
                                                notes.append(updatedNote)
                                            }
                                        }) {
                                            VStack(alignment: .leading) {
                                                Text("Title: \(note.title)")
                                                    .font(.system(size: 15, weight: .semibold))
                                                    .foregroundStyle(.textbg)

                                                Text(note.description)
                                                    .font(.system(size: 15, weight: .regular))
                                                    .foregroundStyle(.textbg)
                                                    .lineLimit(1)
                                            }
                                        }

                                        Spacer()

                                        Button {
                                            toggleFavourite(note)
                                        } label: {
                                            Image(systemName: favouriteNotes.contains(where: { $0.id == note.id }) ? "heart.fill" : "heart")
                                                .foregroundColor(.iconbg)
                                        }
                                        .buttonStyle(BorderlessButtonStyle())
                                    }
                                    .padding()
                                    .listRowBackground(Color.clear)
                                    .cornerRadius(12)
                                }
                                .onDelete(perform: deleteNote)
                            }
                        }
                        .listStyle(PlainListStyle())
                        .scrollContentBackground(.hidden)
                        .background(Color.clear)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding()
//                    }
//                    .padding(.horizontal)

                    
                    
                }
                
                floatbutton()
            }
            
        }
    }
    
    fileprivate func floatbutton() -> some View {
        VStack{
            Spacer()
            NavigationLink {
                NoteAddView()
            } label: {
                Text("+")
                    .font(.title)
                    .frame(width: 60, height: 60)
                    .foregroundStyle(Color.iconbg)
                    .padding(.bottom, 1)
                
            }
            .background(Color.primary)
            .clipShape(Circle())
        }
        .onAppear {
            fetchUsersFromCoreData()
        }
    }
    
    
    func deleteNote(at offsets: IndexSet) {
        for index in offsets {
            let noteToDelete = notes[index]
            
            
            let fetchRequest: NSFetchRequest<NoteItem> = NoteItem.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "title == %@", noteToDelete.title)
            
            do {
                let results = try viewContext.fetch(fetchRequest)
                if let NoteeToDelete = results.first {
                    viewContext.delete(NoteeToDelete)
                    try viewContext.save()
                }
            } catch {
                print("Failed to delete user from Core Data: \(error)")
            }
        }
        
        notes.remove(atOffsets: offsets)
    }
    
    private func toggleFavourite(_ note: NoteViewModel) {
        if let index = favouriteNotes.firstIndex(where: { $0.id == note.id }) {
            favouriteNotes.remove(at: index)
        } else {
            favouriteNotes.append(note)
        }
    }
    
    func fetchUsersFromCoreData() {
        let request: NSFetchRequest<NoteItem> = NoteItem.fetchRequest()
        do {
            let result = try viewContext.fetch(request)
            notes = result.map {
                NoteViewModel(id : $0.id ?? UUID(),title: $0.wrappednoteTitle , description: $0.wrappednoteDescription)
            }
        } catch {
            print("Fetch failed: \(error.localizedDescription)")
        }
    }
    
}


//#Preview {
//    HomePageView()
//}




