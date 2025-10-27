//
//  DataManager.swift
//  Notes
//
//  Created by HarshaHrudhay on 08/08/25.
//

import Foundation
import CoreData
import Combine


class DataManager : ObservableObject{
    
    static let shared = DataManager()
    
    lazy var persistentContainer: NSPersistentContainer = { let container = NSPersistentContainer(name: "NoteData")
        
        
        container.loadPersistentStores { _, error in
            if let error {
                
                fatalError("Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
        return container
    }()
        
    private init() { }
}
