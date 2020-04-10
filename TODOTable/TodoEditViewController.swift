//
//  TodoEditViewController.swift
//  TODOTable
//
//  Created by Gavin Li on 3/26/20.
//  Copyright © 2020 Gavin Li. All rights reserved.
//

import UIKit

class TodoEditViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var todoTitle: UITextField!
    @IBOutlet weak var todoDesc: UITextField!
    @IBOutlet weak var todoDueDate: UIDatePicker!
    @IBOutlet weak var todoImg: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    var curTodoTask: TodoTask?
    var curTodoTaskIndex: Int = -1
    
    weak var todoTaskDetailDelegate: TodoTaskDetailDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.didTapDoneButton(_:)))
        
        if let uwCurTodoTask = curTodoTask {
            todoTitle?.text = uwCurTodoTask.title
            todoDesc?.text = uwCurTodoTask.description
            todoDueDate?.date = uwCurTodoTask.dueDate
            todoImg?.image = UIImage(data: uwCurTodoTask.image)
        }
    }
    
    @IBAction func imgBtnClicked(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.todoImg.contentMode = .scaleAspectFit
            self.todoImg.image = pickedImage
        }
        
        self.dismiss(animated: true, completion: { () -> Void in })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapDoneButton(_ sender: UIBarButtonItem) {
        guard let imgData = (todoImg.image ?? UIImage(named: "placeholder")!).jpegData(compressionQuality: 1.0) else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        let todoTask = TodoTask(title: todoTitle.text ?? "", description: todoDesc.text ?? "", dueDate: todoDueDate.date, image: imgData)
        if curTodoTaskIndex == -1 {
            todoTaskDetailDelegate?.addTodoTask(newTodoTask: todoTask)
        } else if curTodoTaskIndex >= -1 {
            todoTaskDetailDelegate?.editTodoTask(todoTaskIndex: curTodoTaskIndex, newTodoTask: todoTask)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}
