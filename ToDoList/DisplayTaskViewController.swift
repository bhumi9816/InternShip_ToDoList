//
//  DisplayTaskViewController.swift
//  ToDoList
//
//  Created by Bhumi Patel on 6/24/20.
//  Copyright © 2020 Bhumi Patel. All rights reserved.
//

import UIKit

class DisplayTaskViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    
    var listTask: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = listTask
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteTask))
    }
    
    @objc func deleteTask() {
        
        //let new_count = count - 1
        
        //UserDefaults().setValue(new_count, forKey: "count")
        
    }
    

   

}
