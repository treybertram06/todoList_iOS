//
//  User.swift
//  todoList
//
//  Created by Trey Bertram on 2023-09-17.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}
