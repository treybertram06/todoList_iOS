//
//  NewItemViewViewModel.swift
//  todoList
//
//  Created by Trey Bertram on 2023-09-17.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class NewItemViewViewModel: ObservableObject {
    @Published var title = ""
    @Published var dueDate = Date()
    @Published var showAlert = false
    @Published var folderId = ""
    
    init() {}
    
    func save(folderId: String) {
        guard canSave else{
            return
        }
        //get current userid
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        
        //create model
        let newId = UUID().uuidString
        let newItem = ToDoListItem(folderId: folderId,
                                   id: newId,
                                   title: title,
                                   dueDate: dueDate.timeIntervalSince1970,
                                   createdDate: Date().timeIntervalSince1970,
                                   isDone: false)
        
        //save model
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uId)
            .collection("folders")
            .document(folderId)
            .collection("todos")
            .document(newId)
            .setData(newItem.asDictionary())
        
    }
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        guard dueDate >= Date().addingTimeInterval(-86400) else {
            return false
        }
        return true 
    }
}
