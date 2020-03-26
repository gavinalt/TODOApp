//
//  TodoListTableViewController.swift
//  TODOTable
//
//  Created by Gavin Li on 3/25/20.
//  Copyright © 2020 Gavin Li. All rights reserved.
//

import UIKit

class TodoListTableViewCell: UITableViewCell {
    var todoTaskIndex: Int?
    
    @IBOutlet weak var todoTitle: UILabel!
    @IBOutlet weak var todoDueDate: UILabel!
    @IBOutlet weak var todoDesc: UILabel!
    @IBOutlet weak var todoImg: UIImageView!
    @IBOutlet weak var todoCompleteBtn: PassableUIButton!
}

class TodoListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.title = "TODO"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.didTapAddTaskButton(_:)))
    }

    // MARK: - Table view data source
    private var todoTasks = TodoTask.getMockData()

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todoTasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoTaskCell", for: indexPath) as! TodoListTableViewCell
        cell.todoTaskIndex = indexPath.row
        cell.todoCompleteBtn.params["taskIndex"] = indexPath.row

        if indexPath.row < todoTasks.count {
            let cellTask = todoTasks[indexPath.row]
            cell.todoTitle?.text = cellTask.title
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd HH:mm"
            cell.todoDueDate?.text = formatter.string(from: cellTask.dueDate)
            if (cellTask.dueDate < Date.init()) {
                cell.todoDueDate?.textColor = .red
            }
            
            cell.todoDesc?.text = cellTask.description
            cell.todoImg?.image = UIImage(named: cellTask.imgName)
            
//            let accessory: UITableViewCell.AccessoryType = cellTask.done ? .checkmark : .none
//            cell.accessoryType = accessory
        }

        return cell
    }

    @IBAction func cellCompleteTodoTask(_ sender: PassableUIButton) {
        guard let index = sender.params["taskIndex"] else {
            return
        }
        todoTasks[index as! Int].done = true
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            todoTasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.row < todoTasks.count {
            let item = todoTasks[indexPath.row]
            

            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    @objc func didTapAddTaskButton(_ sender: UIBarButtonItem) {
    }

    private func addNewToDoItem(title: String) {
        // The index of the new item will be the current item count
        let newIndex = todoTasks.count

        // Create new item and add it to the todo items list
//        todoTasks.append()

        // Tell the table view a new row has been created
        tableView.insertRows(at: [IndexPath(row: newIndex, section: 0)], with: .top)
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
