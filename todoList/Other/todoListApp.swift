//
//  todoListApp.swift
//  todoList
//
//  Created by Trey Bertram on 2023-09-17.
//

import SwiftUI
import FirebaseCore

@main
struct todoListApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
