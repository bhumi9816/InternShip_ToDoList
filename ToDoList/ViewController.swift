//
//  ViewController.swift
//  ToDoList
//
//  Created by Bhumi Patel on 6/24/20.
//  Copyright © 2020 Bhumi Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //create an outlet for tabelView

    @IBOutlet var tabel_view: UITableView!
    
    //create an array that keeps all the to-do list entries
    var task_entry = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "To-Do List Entry"
        
        tabel_view.delegate = self
        tabel_view.dataSource = self
        
        //set-up initial save
        if !UserDefaults().bool(forKey: "setUp") {
            UserDefaults().set(true, forKey: "setUp")
            UserDefaults().set(0, forKey: "count")   //number of to-do list entries we have
        }
        
    
        //get all the current to-do list entries
        taskUpdated()

        
    }
    
    func taskUpdated() {
        
        
        //so that there are no duplicates
        task_entry.removeAll()
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        for i in 0..<count {
            if let entry = UserDefaults().value(forKey: "task_\(i+1)") as? String {
                task_entry.append(entry)
                
            }
        }
        
        //fetching and reloading the data from the previous view
        tabel_view.reloadData()
        
    }
    
    
    @IBAction func Click_add(_ sender: Any) {
        //going to add another view controller for making an entry
        
        //instantiate the view controller
        let entry = storyboard?.instantiateViewController(identifier: "entry") as! ListEntryViewController        
        entry.title = "New Task"
        
        //calling the listUpdate
        entry.listUpdate = {
            
            //refetch the task that are updated
            DispatchQueue.main.async {
                self.taskUpdated()
            }
            
        }
        
        //since embeded inside navigation controller, we will push the entry
        navigationController?.pushViewController(entry, animated: true)
    }
    


}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tabel_view.deselectRow(at: indexPath, animated: true)
        
        //open the DisplayViewController to display the task entries written
        
        //identifier as the storyboard ID, instantiate the view controller
        let entry = storyboard?.instantiateViewController(identifier: "display") as! DisplayTaskViewController
        entry.title = "New Task"
        entry.listTask = task_entry[indexPath.row]
    
        //since embeded inside navigation controller, we will push the entry
        navigationController?.pushViewController(entry, animated: true)
        
    }
    
    
}

extension ViewController: UITableViewDataSource {
    
    //must have functions for number of rows and cells in our tabel view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //returns the total number of entries
        return task_entry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //dequeing a cell: using a template over and over again using a text label
        let cell = tabel_view.dequeueReusableCell(withIdentifier: "tabel_viewCell", for: indexPath)
        
        
        //at the first position we want one task
        cell.textLabel?.text = task_entry[indexPath.row]
        
        return cell
    }
    
    
}
