//
//  AddNoteView.swift
//  Notes
//
//  Created by HarshaHrudhay on 08/08/25.
//

import SwiftUI
import CoreData

struct NoteAddView: View {
    
    @StateObject var note : NoteViewModel
    
    @State private var notes : [NoteViewModel] = []
    @State var showAlert = false
    //    var notesToEdit : NoteViewModel?
    
    //    @State privte avar didEditNote : Bool = false
    
    //@Binding var favouriteNotes: [NoteViewModel]
    
    
    @Environment(\.dismiss) var dismiss
    
    var onAdd: ((NoteViewModel) -> Void)?
    
    private var dideditNote: Bool
    
    @Environment(\.managedObjectContext) var viewContext
    
    init(noteToEdit: NoteViewModel? = nil, onAdd: ((NoteViewModel) -> Void)? = nil) {
        if let noteToEdit = noteToEdit {
            _note = StateObject(wrappedValue: noteToEdit)
            self.dideditNote = true
        } else {
            _note = StateObject(wrappedValue: NoteViewModel(title: "", description: ""))
            self.dideditNote = false
        }
        self.onAdd = onAdd
//        self.favouriteNotes = favouriteNotes
    }
    
    
    var body: some View {
        
        ZStack {
            
            
            RadialGradient(
                gradient: Gradient(colors: [Color.appbg1, Color.appbg2]),
                center: .center,
                startRadius: 20,
                endRadius: 500
            )
            .ignoresSafeArea()
            
            
//            Color.blue
//                .opacity(0.2)
//                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("Add Note Here")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                    
                }
                
                Divider()
                
                TextField("Add Title", text: $note.title)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                HStack {
                    Text("Add Description Here :")
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                }
                
                TextEditor(text: $note.description)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.clear)
                            .stroke(Color.gray, lineWidth: 0.5)
                    })
                    .foregroundStyle(Color.black)
                    .scrollContentBackground(.hidden)
                    .frame(height: 150)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                
                
                Button {
                    if note.validate() {
                      
                        let fetchRequest: NSFetchRequest<NoteItem> = NoteItem.fetchRequest()
                        fetchRequest.predicate = NSPredicate(format: "id == %@", note.id as CVarArg)
                        
                        do {
                            let results = try viewContext.fetch(fetchRequest)
                            
                            let noteToEdit = results.first ?? NoteItem(context: viewContext)
                            
                            noteToEdit.id = note.id
                            noteToEdit.title = note.title
                            noteToEdit.noteDescription = note.description
                            
//                            if noteToEdit.id == nil {
//                                noteToEdit.id = note.id
//                            }
                            
                            try viewContext.save()
                            
                            onAdd?(note)
                            dismiss()
                            
                            
                            } catch {
                            print("Failed to save user: \(error)")
                        }
                    }else {
                        showAlert = true
                    }
                }
                
                label: {
                    Text(dideditNote ? "Update" : "Create")                  // notesToEdit == nil ? "Create":
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(Color.textbg)
                        .frame(height: 40)
                        .frame(maxWidth: .infinity)
                        .background(Color.appbg2)
                        .clipShape(RoundedRectangle(cornerRadius: 50))
                    
                } // )
                .padding(.top)
                .padding(.horizontal, 15)
                
                Spacer()
                
            }
            .alert("Invalid Details", isPresented: $showAlert) {
                
            } message: {
                Text("Please Fill the Empty Spaces")
            }
            
        }
        
    }
    
}






#Preview {
    NoteAddView()
}

