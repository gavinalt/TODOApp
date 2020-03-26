//
//  TodoTask.swift
//  TODOTable
//
//  Created by Gavin Li on 3/25/20.
//  Copyright © 2020 Gavin Li. All rights reserved.
//

import Foundation

class TodoTask {
    var title: String
    var description: String
    var dueDate: Date
    var imgName: String
    var done: Bool

    public init(title: String, description: String, dueDate: Date, imageName: String) {
        self.title = title
        self.description = description
        self.dueDate = dueDate
        self.imgName = imageName
        self.done = false
    }
}

extension TodoTask {
    public class func getMockData() -> [TodoTask] {
        return [
            TodoTask(title: "Testtask1", description: "testtest11", dueDate: Date.init(), imageName: "placeholder"),
            TodoTask(title: "Testtask2", description: "testtest22", dueDate: Date.distantFuture, imageName: "placeholder")
        ]
    }
}
