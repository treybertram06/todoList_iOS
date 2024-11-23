//
//  ToDoListItemsView.swift
//  todoList
//
//  Created by Trey Bertram on 2023-09-17.
//

import FirebaseFirestoreSwift
import SwiftUI

struct ToDoListView: View {
    @StateObject var viewModel: ToDoListViewViewModel
    @FirestoreQuery var items: [ToDoListItem]
    let folderId: String
    
    
    init(userId: String, folderId: String) {
        self._items = FirestoreQuery(
            collectionPath: "users/\(userId)/folders/\(folderId)/todos"
        )
        self._viewModel = StateObject(
            wrappedValue: ToDoListViewViewModel(userId: userId, folderId: folderId)
        )
        self.folderId = folderId
    }
    var body: some View {
        VStack {
            if items.isEmpty {
                Text("No tasks yet.")
                    .font(.title)
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List(items) { item in
                    ToDoListItemView(item: item, folderId: folderId)
                        .swipeActions {
                            Button {
                                viewModel.delete(id: item.id,
                                folderId: folderId)
                            } label: {
                                Text("Delete")
                            }
                            .tint(.red)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
                Spacer()
            }
            .navigationTitle("Tasks")
            .toolbar {
                Button {
                    viewModel.showingNewItemView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingNewItemView) {
                NewItemView(newItemPresented: $viewModel.showingNewItemView, folderId: folderId )
                
            }
        
    }
}

struct ToDoListItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView(userId: "uW36HKYXI1ZaVVkY3Cuy13u6Hnr2", folderId: "3276652A-0F01-4281-8321-13EA99214A6D")
    }
}
