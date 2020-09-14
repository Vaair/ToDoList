//
//  TableViewController.swift
//  ToDoList
//
//  Created by Лера Тарасенко on 14.09.2020.
//  Copyright © 2020 Лера Тарасенко. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var tasks: [Task] = [] //чтобы не было ошибки удаляем в локейшн directed data и перезагружаем проект
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func saveTask(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "New Task", message: "Please add a new task", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            let tf = alertController.textFields?.first
            if let newTaskTitle = tf?.text {
                //self.tasks.insert(newTask, at: 0)
                self.saveTask(withTitle: newTaskTitle)
                self.tableView.reloadData()
            }
        }
        alertController.addTextField()
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated:  true, completion: nil )
    }
    
    private func saveTask(withTitle title: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext //добрались до контекста
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
        
        let taskObject = Task(entity: entity, insertInto: context)
        taskObject.title = title
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.title
        
        return cell
    }
    
    
    
}
