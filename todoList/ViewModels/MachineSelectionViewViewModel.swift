//
//  MachineSelectionViewViewModel.swift
//  todoList
//
//  Created by Trey Bertram on 2023-09-20.
//

import FirebaseFirestore
import Foundation

class MachineSelectionViewViewModel: ObservableObject {
    @Published var folders: [Folder] = []
    @Published var showingNewFolderView = false

    public var userId: String
    private let db = Firestore.firestore()
    private var listener: ListenerRegistration?

    
    init(userId: String) {
            self.userId = userId
            listenForChanges()
        }
    
    private func listenForChanges() {
        listener = db.collection("users").document(userId).collection("folders")
            .addSnapshotListener { (querySnapshot, err) in
                if let querySnapshot = querySnapshot {
                    self.folders = querySnapshot.documents.compactMap { document in
                        try? document.data(as: Folder.self)
                    }
                } else if let err = err {
                    print("Error getting documents: \(err)")
                }
            }
    }

    deinit {
        listener?.remove()  // Stop listening for changes when the view model is deinitialized
    }
    
    private func fetchFolders() {
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("folders")
            .getDocuments { (querySnapshot, _) in
            self.folders = querySnapshot?.documents.compactMap { document in
                try? document.data(as: Folder.self)
            } ?? []
        }
    }
    
    //Delete todo list item
    func deleteFolder(userId: String, folderId: String) {
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("folders")
            .document(folderId)
            .delete()
    }
}
