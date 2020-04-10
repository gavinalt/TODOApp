//
//  TodoTaskList.swift
//  TODOTable
//
//  Created by Gavin Li on 4/10/20.
//  Copyright © 2020 Gavin Li. All rights reserved.
//

import Foundation

class TodoTaskList: Codable {
    static let fileName = "TodoApp"
    
    var list: [TodoTask]
    
    init() {
        list = []
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let entries = try container.decode([TodoTask].self)
        list = entries
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(list)
    }
    
    func insert(_ task: TodoTask) {
        list.append(task)
    }
    
    func value(forIndex index: Int) -> TodoTask {
        return list[index]
    }
    
    func indexOf(task: TodoTask) -> Int? {
        return list.firstIndex { $0 === task }
    }
    
    func removeValue(task: TodoTask) {
        list.removeAll { $0 === task }
    }
    
    func getFinishedTasks() -> [TodoTask] {
        return list.filter { $0.done == true }
    }
    
    func getUnfinishedTasks() -> [TodoTask] {
        return list.filter { $0.done == false }
    }
    
    static func persistencePath(withName name: String, using fileManager: FileManager) throws -> URL {
        let folderURL = try fileManager.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        return folderURL.appendingPathComponent(name + ".json")
    }
    
    func saveToDisk(withName name: String, using fileManager: FileManager = .default) throws {
        let fileURL = try TodoTaskList.persistencePath(withName: name, using: fileManager)
        let data = try JSONEncoder().encode(self)
        try data.write(to: fileURL)
    }
}
