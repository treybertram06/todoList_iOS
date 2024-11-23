//
//  ToDoListItem.swift
//  todoList
//
//  Created by Trey Bertram on 2023-09-17.
//

import Foundation

struct ToDoListItem: Codable, Identifiable {
    let folderId: String
    let id: String
    let title: String
    let dueDate: TimeInterval
    let createdDate: TimeInterval
    var isDone: Bool
    
    mutating func setDone(_ state: Bool) {
        isDone = state
    }
}
