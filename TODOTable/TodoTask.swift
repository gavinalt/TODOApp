//
//  TodoTask.swift
//  TODOTable
//
//  Created by Gavin Li on 3/25/20.
//  Copyright © 2020 Gavin Li. All rights reserved.
//

import Foundation

class TodoTask: Codable {
    var title: String
    var description: String
    var dueDate: Date
    var image: Data
    var done: Bool

    init(title: String, description: String, dueDate: Date, image: Data) {
        self.title = title
        self.description = description
        self.dueDate = dueDate
        self.image = image
        self.done = false
    }
    
    func updateTask(newTodoTask: TodoTask) {
        title = newTodoTask.title
        description = newTodoTask.description
        dueDate = newTodoTask.dueDate
        image = newTodoTask.image
        done = newTodoTask.done
    }
}
