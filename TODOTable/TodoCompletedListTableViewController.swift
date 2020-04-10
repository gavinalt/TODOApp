//
//  TodoCompletedListTableViewController.swift
//  TODOTable
//
//  Created by Gavin Li on 3/25/20.
//  Copyright © 2020 Gavin Li. All rights reserved.
//

import UIKit

class TodoCompletedListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        todoTasksDone = SceneDelegate.todoTaskList.getFinishedTasks()
    }

    // MARK: - Table view data source
    var todoTasksDone: [TodoTask] = [] {
        didSet {
            if isViewLoaded {
                tableView.reloadData()
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todoTasksDone.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoTaskCompleted", for: indexPath)

        if indexPath.row < todoTasksDone.count {
            cell.textLabel?.text = todoTasksDone[indexPath.row].title
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd HH:mm"
            cell.detailTextLabel?.text = formatter.string(from: todoTasksDone[indexPath.row].dueDate)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
