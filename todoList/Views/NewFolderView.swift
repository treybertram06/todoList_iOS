//
//  NewFolderView.swift
//  todoList
//
//  Created by Trey Bertram on 2023-09-20.
//

import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore
import SwiftUI

struct NewFolderView: View {
    @StateObject var viewModel = NewFolderViewViewModel()
    @Binding var newFolderPresented: Bool
    @State var folders: [Folder] = []
    @State var selectedFolder: Folder?

    let userId = Auth.auth().currentUser?.uid ?? ""

    var body: some View {
        VStack {
            Text("New Folder")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 100)
            Form {
                
                //title
                TextField("Name", text: $viewModel.name)
                    .textFieldStyle(DefaultTextFieldStyle())
                //button
                ButtonView(title: "Save",
                           background: .blue) {
                    if viewModel.canSave {
                        viewModel.save(name: viewModel.name)
                        newFolderPresented = false
                    } else {
                        viewModel.showAlert = true
                    }
                }
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"),
                      message: Text("Please fill in name.")
                )
            }
        }
        .onAppear {
            let userId = Auth.auth().currentUser?.uid ?? ""
            let db = Firestore.firestore()
            db.collection("users/\(userId)/folders").getDocuments { (querySnapshot, _) in
                self.folders = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: Folder.self)
                } ?? []
            }
        }
    }
}

struct NewFolderView_Previews: PreviewProvider {
    static var previews: some View {
        NewFolderView(newFolderPresented: Binding(get: {
            return true
        }, set: { _ in
            
        }))
    }
}
