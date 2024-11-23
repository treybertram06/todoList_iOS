//
//  MachineSelectionView.swift
//  todoList
//
//  Created by Trey Bertram on 2023-09-20.
//

import FirebaseFirestoreSwift
import SwiftUI

struct MachineSelectionView: View {
    @StateObject var viewModel: MachineSelectionViewViewModel
    private let userId: String

    init(userId: String) {
        _viewModel = StateObject(wrappedValue: MachineSelectionViewViewModel(userId: userId))
        self.userId = userId
    }

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.folders.isEmpty {
                    Text("No folders yet.")
                        .font(.title)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(viewModel.folders) { folder in
                        NavigationLink(destination: ToDoListView(userId: viewModel.userId, folderId: folder.id ?? "")) {
                            FolderView(folder: folder)
                        }
                        .swipeActions {
                            Button {
                                viewModel.deleteFolder(userId: userId, folderId: folder.id ?? "")
                            } label: {
                                Text("Delete")
                            }
                            .tint(.red)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationBarTitle("To Do Lists")
            .toolbar {
                Button {
                    viewModel.showingNewFolderView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingNewFolderView) {
                NewFolderView(newFolderPresented: $viewModel.showingNewFolderView)
            }
        }
        .ignoresSafeArea(edges: .top)
    }
}

struct MachineSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        let userId = "uW36HKYXI1ZaVVkY3Cuy13u6Hnr2"
        let folderId = "3276652A-0F01-4281-8321-13EA99214A6D"
        let viewModel = MachineSelectionViewViewModel(userId: userId) // Provide a mock view model
     // Provide a mock user id
        MachineSelectionView(userId: userId)
    }
}
