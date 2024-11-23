//
//  NewItemView.swift
//  todoList
//
//  Created by Trey Bertram on 2023-09-17.
//

import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore
import SwiftUI

struct NewItemView: View {
    @StateObject var viewModel = NewItemViewViewModel()
    @Binding var newItemPresented: Bool
    let folderId: String
    
    @State var folders: [Folder] = []

    let userId = Auth.auth().currentUser?.uid ?? ""

    var body: some View {
        VStack {
            Text("New Item")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 100)
            Form {
                //title
                TextField("Title", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                //due date
                DatePicker("Due date", selection: $viewModel.dueDate)
                    .datePickerStyle(GraphicalDatePickerStyle())
                //button
                ButtonView(title: "Save", background: .blue) {
                    if viewModel.canSave {
                        viewModel.save(folderId: folderId)
                        newItemPresented = false
                    } else {
                        viewModel.showAlert = true
                    }
                }
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"),
                      message: Text("Please fill in all fields and select due date today or later.")
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

struct NewItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewItemView(newItemPresented: Binding(get: {
            return true
        }, set: { _ in
            
        }), folderId: "")
    }
}
