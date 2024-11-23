//
//  Folder.swift
//  todoList
//
//  Created by Trey Bertram on 2023-09-20.
//

import FirebaseFirestoreSwift
import Foundation

struct Folder: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    
    func folderAsDictionary() -> [String: Any] {
            return ["name": name]
    }
}
