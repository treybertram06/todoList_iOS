//
//  ToDoListViewViewModel.swift
//  todoList
//
//  Created by Trey Bertram on 2023-09-17.
//

import FirebaseFirestore
import Foundation

class ToDoListViewViewModel: ObservableObject {
    @Published var showingNewItemView = false
    @Published var folderId: String
    
    private let userId: String
    
    init(userId: String, folderId: String) {
        self.userId = userId
        self.folderId = folderId
    }
    
    //Delete todo list item
    func delete(id: String, folderId: String) {
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("folders")
            .document(folderId)
            .collection("todos")
            .document(id)
            .delete()
    }
}
