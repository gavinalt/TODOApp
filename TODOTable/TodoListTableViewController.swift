//
//  TodoListTableViewController.swift
//  TODOTable
//
//  Created by Gavin Li on 3/25/20.
//  Copyright © 2020 Gavin Li. All rights reserved.
//

import UIKit

class TodoListTableViewCell: UITableViewCell {
    @IBOutlet weak var todoTitle: UILabel!
    @IBOutlet weak var todoDueDate: UILabel!
    @IBOutlet weak var todoDesc: UILabel!
    @IBOutlet weak var todoImg: UIImageView!
    @IBOutlet weak var todoCompleteBtn: PassableUIButton!
}

class TodoListTableViewController: UITableViewController, TodoTaskDetailDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.title = "TODO"
        todoTasks = SceneDelegate.todoTaskList.getUnfinishedTasks()
    }

    // MARK: - Table view data source
    var todoTasks: [TodoTask] = []

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoTasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoTaskCell", for: indexPath) as! TodoListTableViewCell
        cell.todoCompleteBtn.params["taskIndex"] = indexPath.row

        if indexPath.row < todoTasks.count {
            let cellTask = todoTasks[indexPath.row]
            cell.todoTitle.text = cellTask.title
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd HH:mm"
            cell.todoDueDate.text = formatter.string(from: cellTask.dueDate)
            if (cellTask.dueDate < Date.init()) {
                cell.todoDueDate.textColor = .red
            } else {
                cell.todoDueDate.textColor = .black
            }
            
            cell.todoDesc.text = cellTask.description
            cell.todoImg.image = UIImage(data: cellTask.image)
            
//            let accessory: UITableViewCell.AccessoryType = cellTask.done ? .checkmark : .none
//            cell.accessoryType = accessory
        }

        return cell
    }

    @IBAction func cellCompleteTodoTask(_ sender: PassableUIButton) {
        guard let index = sender.params["taskIndex"] as? Int else { return }
        if let listIndex = SceneDelegate.todoTaskList.indexOf(task: todoTasks[index]) {
            SceneDelegate.todoTaskList.value(forIndex: listIndex).done = true
        }
        todoTasks.remove(at: index)
        tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            SceneDelegate.todoTaskList.removeValue(task: todoTasks[indexPath.row])
            todoTasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cellSelectedSegue" {
            let segueDestination = segue.destination as! TodoEditViewController
            if let taskIndex = tableView.indexPathForSelectedRow?.row {
                segueDestination.todoTaskDetailDelegate = self
                segueDestination.curTodoTask = todoTasks[taskIndex]
                segueDestination.curTodoTaskIndex = taskIndex
            }
        } else if segue.identifier == "newTodoSegue" {
            let segueDestination = segue.destination as! TodoEditViewController
            segueDestination.todoTaskDetailDelegate = self
            segueDestination.curTodoTaskIndex = -1
        }
    }
    
    func addTodoTask(newTodoTask: TodoTask) {
        let newIndex = todoTasks.count
        todoTasks.append(newTodoTask)
        tableView.insertRows(at: [IndexPath(row: newIndex, section: 0)], with: .top)
        SceneDelegate.todoTaskList.insert(newTodoTask)
    }
    
    func editTodoTask(todoTaskIndex: Int, newTodoTask: TodoTask) {
        let oldTodoTask = todoTasks[todoTaskIndex]
        oldTodoTask.updateTask(newTodoTask: newTodoTask)
        tableView.reloadRows(at: [IndexPath(row: todoTaskIndex, section: 0)], with: .fade)
        let listIndex = SceneDelegate.todoTaskList.indexOf(task: oldTodoTask)!
        SceneDelegate.todoTaskList.value(forIndex: listIndex).updateTask(newTodoTask: newTodoTask)
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
