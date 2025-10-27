//
//  NoteItem+CoreDataProperties.swift
//  Notes
//
//  Created by HarshaHrudhay on 08/08/25.
//
//

import Foundation
import CoreData


extension NoteItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteItem> {
        return NSFetchRequest<NoteItem>(entityName: "NoteItem")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var noteDescription: String?

}

extension NoteItem : Identifiable {

}


extension NoteItem {
    
    var wrappedId: UUID {
        return id!
    }
    
    var wrappednoteTitle: String {
        return title ?? ""
    }
    var wrappednoteDescription: String {
        return noteDescription ?? ""
    }
}
