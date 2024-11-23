//
//  FolderViewViewModel.swift
//  todoList
//
//  Created by Trey Bertram on 2023-09-20.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class NewFolderViewViewModel: ObservableObject {
    @Published var name = ""
    @Published var showAlert = false
    
    init() {}
    
    func save(name: String) {
        guard canSave else{
            return
        }
        //get current userid
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        
        //create model
        let newId = UUID().uuidString
        let newFolder = Folder(name: name)
        
        //save model
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uId)
            .collection("folders")
            .document(newId)
            .setData(newFolder.folderAsDictionary())
        
    }
    var canSave: Bool {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        return true
    }
}

