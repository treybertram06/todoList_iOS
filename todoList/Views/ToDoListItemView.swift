//
//  ToDoListItemView.swift
//  todoList
//
//  Created by Trey Bertram on 2023-09-17.
//

import SwiftUI

struct ToDoListItemView: View {
    @StateObject var viewModel: ToDoListItemViewViewModel
    let item: ToDoListItem
    let folderId: String

    init(item: ToDoListItem, folderId: String) {
          self.item = item
          self.folderId = folderId
          self._viewModel = StateObject(wrappedValue: ToDoListItemViewViewModel(folderId: folderId))
      }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.body)
                Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                    .font(.footnote)
                    .foregroundColor(Color(.secondaryLabel))
            }
            Spacer()
            
            Button {
                viewModel.toggleIsDone(item: item)
            } label: {
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(Color.blue)
            }
        }
        .padding(.bottom, 5)
        .padding(.top, 5)
    }
}

struct ToDoListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListItemView(item: .init(folderId: "123", id: "123",
                                     title: "Item One",
                                     dueDate: Date().timeIntervalSince1970,
                                     createdDate: Date().timeIntervalSince1970,
                                     isDone: false), folderId: "")
    }
}
