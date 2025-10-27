//
//  NoteModel.swift
//  Notes
//
//  Created by HarshaHrudhay on 08/08/25.
//

import Foundation
import SwiftUI
import Combine

class NoteViewModel : ObservableObject , Identifiable {
    
    var id : UUID
    
    @Published var title: String 
    @Published var description: String
    
    @Published var alertMessage : String = ""
    @Published var titleError: String = ""
    @Published var descriptionError: String = ""

    
    
    init(id: UUID = UUID(), title: String, description: String) {
        
        self.id = id
        self.title = title
        self.description = description
        
    }
    
    
    func validate() -> Bool{
        
//        titleError = ""
//        descriptionError = ""

        
        if description.trimmingCharacters(in: .whitespacesAndNewlines).count < 5 {
            descriptionError = "Name must be at least 5 characters"
            return false
        }
        if title.trimmingCharacters(in: .whitespacesAndNewlines).count < 5 {
            titleError = "Name must be at least 5 characters"
            return false
        }
        return  true
    }
    
}


