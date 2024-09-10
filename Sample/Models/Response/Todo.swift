//
//  Todo.swift
//  Sample
//
//  Created by Jevon Putra on 10/09/24.
//

import Foundation

struct Todo: Codable, Identifiable {
    let userId, id: Int?
    let title: String?
    let completed: Bool?
    
    init(userId: Int? = -1, id: Int? = -1, title: String? = "Ini Title", completed: Bool? = false) {
        self.userId = userId
        self.id = id
        self.title = title
        self.completed = completed
    }
    
    static func MockTodo() -> Todo {
        return Todo.init()
    }
}
