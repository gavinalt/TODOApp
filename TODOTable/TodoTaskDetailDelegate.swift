//
//  TodoTaskDetailDelegate.swift
//  TODOTable
//
//  Created by Gavin Li on 4/10/20.
//  Copyright © 2020 Gavin Li. All rights reserved.
//

import Foundation

protocol TodoTaskDetailDelegate: class {
    func addTodoTask(newTodoTask: TodoTask)
    func editTodoTask(todoTaskIndex: Int, newTodoTask: TodoTask)
}
