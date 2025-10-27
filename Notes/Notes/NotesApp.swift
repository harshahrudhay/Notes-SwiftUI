//
//  NotesApp.swift
//  Notes
//
//  Created by HarshaHrudhay on 27/10/25.
//

import SwiftUI
import CoreData

@main
struct NotesApp: App {
    
    @StateObject private var dataManager = DataManager.shared
    
    var body: some Scene {
        
        WindowGroup {
            
            ContentView()
                .environment(\.managedObjectContext,dataManager.persistentContainer.viewContext)
        }
        
    }
    
}
